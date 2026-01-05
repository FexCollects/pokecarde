SECTION "payload/event/dollgift.regirock", ROM0
INCLUDE "include/event.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataStartRegirock::
	Mystery_Event
	GBAPtr ScriptStartRegirock
	GBAPtr RegirockEnd

ScriptStartRegirock:
	db PRELOAD_SCRIPT
	GBAPtr PreloadScriptStartRegirock
	db END_OF_CHUNKS

PreloadScriptStartRegirock:
	setvirtualaddress PreloadScriptStartRegirock
	bufferdecorationname $00, $0076 ;Regirock doll
	adddecoration $0076
	compare LASTRESULT, $0000
	virtualgotoif $01, TransferFailRegirock
	virtualloadpointer TransferSuccessRegirock
	setbyte $02
	end

TransferFailRegirock:
	virtualloadpointer TransferFailTextRegirock
	setbyte $03
	end

TransferSuccessRegirock:
        db "\\v2 has been sent!@"
	;db $FD,$02,$37,$00,$05,$08,$27,$2A,$13,$00,$07,$10,$AB,$FF

TransferFailTextRegirock:
        db "There is no room for the\\n"
	db "\\v2...@"
	;db $FD,$02,$2D,$00,$02,$2A,$29,$FE,$46,$0C,$36,$37,$00,$01,$02,$13,$00,$02,$15,$06,$50,$10,$B0,$FF
RegirockEnd:
	db $00,$00,$00

POPC
