INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"
SECTION "payload_registeel", ROM0

MACRO myMystery_Event
	db $01,$00,$00,$00,$02,$02,$00,$02,$00,$00,$00,$04,$00,$80,$01,$00,$00
ENDM

MACRO RelPtr
	dd $02000000 + \1 - DataStartRegisteel
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

DataStartRegisteel::
	myMystery_Event
	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	RelPtr ScriptStartRegisteel
	RelPtr RegisteelEnd

ScriptStartRegisteel:
	db PRELOAD_SCRIPT
	RelPtr PreloadScriptStartRegisteel
	db END_OF_CHUNKS

PreloadScriptStartRegisteel:
	Relsetvirtualaddress PreloadScriptStartRegisteel
	bufferdecorationname $00, $0078 ;Registeel doll
	adddecoration $0078
	compare $800D, $0000
	Relvirtualgotoif $01, TransferFailRegisteel
	Relvirtualloadpointer TransferSuccessRegisteel
	setbyte $02
	end

TransferFailRegisteel:
	Relvirtualloadpointer TransferFailTextRegisteel
	setbyte $03
	end

TransferSuccessRegisteel:
	Text_EN "\v2 has been sent!@"
	;db $FD,$02,$37,$00,$05,$08,$27,$2A,$13,$00,$07,$10,$AB,$FF

TransferFailTextRegisteel:
	Text_EN "There is no room for the\n"
	Text_EN "\v2...@"
	;db $FD,$02,$2D,$00,$02,$2A,$29,$FE,$46,$0C,$36,$37,$00,$01,$02,$13,$00,$02,$15,$06,$50,$10,$B0,$FF
RegisteelEnd:
	db $00,$00,$00
