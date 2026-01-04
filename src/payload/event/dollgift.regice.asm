SECTION "payload/event/dollgift.regice", ROM0
INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

MACRO myMystery_Event
	db $01,$00,$00,$00,$02,$02,$00,$02,$00,$00,$00,$04,$00,$80,$01,$00,$00
ENDM

MACRO RelPtr
	dd $02000000 + \1 - DataStartRegice
ENDM

MACRO Relsetvirtualaddress
	db $B8
	RelPtr \1
	ENDM
MACRO Relvirtualgotoif
	db $BB
	db \1
	RelPtr \2
	ENDM
MACRO Relvirtualmsgbox
	db $BD
	RelPtr \1
	ENDM
MACRO Relvirtualloadpointer
	db $BE
	RelPtr \1
	ENDM

DataStartRegice::
	myMystery_Event
	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	RelPtr ScriptStartRegice
	RelPtr RegiceEnd

ScriptStartRegice:
	db PRELOAD_SCRIPT
	RelPtr PreloadScriptStartRegice
	db END_OF_CHUNKS

PreloadScriptStartRegice:
	Relsetvirtualaddress PreloadScriptStartRegice
	bufferdecorationname $00, $0077 ;Regice doll
	adddecoration $0077
	compare $800D, $0000
	Relvirtualgotoif $01, TransferFailRegice
	Relvirtualloadpointer TransferSuccessRegice
	setbyte $02
	end

TransferFailRegice:
	Relvirtualloadpointer TransferFailTextRegice
	setbyte $03
	end

TransferSuccessRegice:
        db "\\v2 has been sent!@"
	;db $FD,$02,$37,$00,$05,$08,$27,$2A,$13,$00,$07,$10,$AB,$FF

TransferFailTextRegice:
        db "There is no room for the\\n"
	db "\\v2...@"
	;db $FD,$02,$2D,$00,$02,$2A,$29,$FE,$46,$0C,$36,$37,$00,$01,$02,$13,$00,$02,$15,$06,$50,$10,$B0,$FF
RegiceEnd:
	db $00,$00,$00

POPC
