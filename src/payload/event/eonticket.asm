SECTION "payload/event/eonticket", ROM0
INCLUDE "include/event.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Mystery_Event
    GBAPtr DataStart
    GBAPtr DataEnd

DataStart:
    db IN_GAME_SCRIPT
    db 8,1 ; Petalburg Gym
    db 1   ; Norman
    GBAPtr NormanScriptStart
    GBAPtr NormanScriptEnd


    db MIX_RECORDS_ITEM
    db 1  ; ???
IF REGION == REGION_DE
    db 5  ; distribution limit from German debug ROM
ELSE
    db 30 ; distribution limit from English release
ENDC
    dw EON_TICKET


    db PRELOAD_SCRIPT
    GBAPtr PreloadScriptStart


    db END_OF_CHUNKS


GoSeeYourFather:
IF REGION == REGION_DE
    db "Lauf und besuche deinen Vater in der\\n"
    db "ARENA von BLÜTENBURG CITY.@"
ELSE
    db "Go see your father at the GYM in\\n"
    db "PETALBURG.@"
ENDC


NormanScriptStart:
    setvirtualaddress NormanScriptStart
    
    checkitem EON_TICKET, 1
    compare LASTRESULT, 1
    virtualgotoif 1, .delete_script
    checkpcitem EON_TICKET, 1
    compare LASTRESULT, 1
    virtualgotoif 1, .delete_script
    checkflag $00CE
    virtualgotoif 1, .delete_script
    
    lock
    faceplayer
    virtualmsgbox GoodToSeeYou
    waitmsg
    waitkeypress

    checkitemroom EON_TICKET, 1
    compare LASTRESULT, 0
    virtualgotoif 1, NoRoomToGive

    copyvarifnotzero $8000, EON_TICKET
    copyvarifnotzero $8001, 1
    callstd 0
    setflag $0853
    virtualmsgbox AppearsToBeAFerryTicket
    waitmsg
    waitkeypress
    release
.delete_script
    killscript

NoRoomToGive:
    virtualmsgbox KeyItemsPocketIsFull
    waitmsg
    waitkeypress
    release
    end

GoodToSeeYou:
IF REGION == REGION_DE
    db "VATER: \\v1! Schön, dich zu sehen!\\n"
    db "Hier ist ein Brief für dich, \\v1.@"
ELSE
    db "DAD“\\v1! Good to see you!\\n"
    db "There’s a letter here for you,\\v1.@"
ENDC


AppearsToBeAFerryTicket:
IF REGION == REGION_DE
    db "VATER: Ich bin mir nicht sicher, es\\n"
    db "könnte ein TICKET für eine Fähre sein.\\p"
    db "Du solltest nach SEEGRASULB CITY gehen\\n"
    db "und dich dort genauer erkundigen.@"
ELSE
    db "DAD“It appears to be a ferry TICKET.\\n"
    db "but I’ve never seen one like it before.\\l"
    db "You should visit LILYCOVE and ask\\n"
    db "about it there.@"
ENDC


KeyItemsPocketIsFull:
IF REGION == REGION_DE
    db "VATER: \\v1, die BASIS-TASCHE\\n"
    db "deines BEUTELS ist voll.\\p"
    db "Lagere einige deiner Basis-Items in\\n"
    db "deinem PC und komm dann wieder.@"
ELSE
    db "DAD“\\v1’ the KEY ITEMS POCKET in\\n"
    db "your BAG is full.\\p"
    db "Move some key items for safekeeping\\n"
    db "in your PC’ then come see me.@"
ENDC


; whoever wrote the English text obviously wasn’t
; familiar with R/S’s character set…
NormanScriptEnd:


PreloadScriptStart:
    setvirtualaddress PreloadScriptStart
    
    checkitem EON_TICKET, 1
    compare LASTRESULT, 1
    virtualgotoif 1, .ineligible
    checkpcitem EON_TICKET, 1
    compare LASTRESULT, 1
    virtualgotoif 1, .ineligible
    checkflag $00CE
    virtualgotoif 1, .ineligible

    checkitemroom EON_TICKET, 1
    compare LASTRESULT, 0
    virtualgotoif 1, .no_room

    virtualloadpointer GoSeeYourFather
    setbyte 2
    end

.ineligible
    virtualloadpointer MayBeplayedOnlyOnce
    setbyte 3
    end

.no_room
    virtualloadpointer BagsKeyItemsPocketFull
    setbyte 3
    end

MayBeplayedOnlyOnce:
; …or with the English language.
IF REGION == REGION_DE
    db "Dieses GESCHEHEN kann nur einmal\\n"
    db "gespielt werden.@"
ELSE
    db "This EVENT may beplayed only once.@"
ENDC

BagsKeyItemsPocketFull:
IF REGION == REGION_DE
    db "Deine BASIS-TASCHE ist voll.@"
ELSE
    db "Your BAG’s KEY ITEMS POCKET is full.@"
ENDC

DataEnd:
    db 0,0,0 ; padding

POPC
