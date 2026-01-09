SECTION "payload/event/gift.doll.registeel", ROM0
INCLUDE "include/event.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataStartRegisteel::
    Mystery_Event
    GBAPtr ScriptStartRegisteel
    GBAPtr RegisteelEnd

ScriptStartRegisteel:
    db PRELOAD_SCRIPT
    GBAPtr PreloadScriptStartRegisteel
    db END_OF_CHUNKS

PreloadScriptStartRegisteel:
    setvirtualaddress PreloadScriptStartRegisteel
    bufferdecorationname $00, $0078 ;Registeel doll
    adddecoration $0078
    compare LASTRESULT, $0000
    virtualgotoif $01, TransferFailRegisteel
    virtualloadpointer TransferSuccessRegisteel
    setbyte $02
    end

TransferFailRegisteel:
    virtualloadpointer TransferFailTextRegisteel
    setbyte $03
    end

TransferSuccessRegisteel:
        db "\\v2 has been sent!@"
    ;db $FD,$02,$37,$00,$05,$08,$27,$2A,$13,$00,$07,$10,$AB,$FF

TransferFailTextRegisteel:
        db "There is no room for the\\n"
    db "\\v2...@"
    ;db $FD,$02,$2D,$00,$02,$2A,$29,$FE,$46,$0C,$36,$37,$00,$01,$02,$13,$00,$02,$15,$06,$50,$10,$B0,$FF
RegisteelEnd:
    db $00,$00,$00

POPC
