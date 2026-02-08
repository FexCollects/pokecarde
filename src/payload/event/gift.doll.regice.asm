SECTION "payload/event/gift.doll.regice", ROM0
INCLUDE "include/event.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataStartRegice::
    Mystery_Event
    GBAPtr ScriptStartRegice
    GBAPtr RegiceEnd

ScriptStartRegice:
    db PRELOAD_SCRIPT
    GBAPtr PreloadScriptStartRegice
    db END_OF_CHUNKS

PreloadScriptStartRegice:
    setvirtualaddress PreloadScriptStartRegice
    bufferdecorationname $00, $0077 ;Regice doll
    adddecoration $0077
    compare LASTRESULT, $0000
    virtualgotoif $01, TransferFailRegice
    virtualloadpointer TransferSuccessRegice
    setbyte $02
    end

TransferFailRegice:
    virtualloadpointer TransferFailTextRegice
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
