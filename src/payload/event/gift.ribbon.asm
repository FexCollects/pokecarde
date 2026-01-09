SECTION "payload/event/gift.ribbon", ROM0
INCLUDE "constants/ribbons.asm"
INCLUDE "include/event.asm"
INCLUDE "include/charmaps.asm"

DataPacket::
    Mystery_Event
    GBAPtr DataStart
    GBAPtr DataEnd

DataStart:
    db AWARD_RIBBON 
    db MARINE_RIBBON
    db REGIONAL_TOURNEY_CHAMPION_2003
    db END_OF_CHUNKS

DataEnd:
    db 0,0,0 ; padding
