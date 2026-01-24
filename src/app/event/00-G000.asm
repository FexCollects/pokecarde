SECTION "app/event/00-G000", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/erapi.asm"

dstruct ER_CustomSprite, \
  SpriteData, \
    .TilePtr=TicketSprite, \
    .PalettePtr=TicketPalette, \
    .Width=21, \
    .Height=8, \
    .FramesPerBank=1, \
    .Unknown=1, \
    .HitBoxWidth=1, \
    .HitBoxHeight=1, \
    .FrameCount=1

Instructions1:: ; 1921
    db "Link e-Reader to Pokémon Ruby or\n"
    db "Sapphire and select MYSTERY EVENTS\n"
    db "on the game's main menu.\n"
    db "Press the B Button to cancel.\0"

Instructions2:: ; 199d
    db "Press the A Button on the Game Boy\n"
    db "Advance containing Pokémon Ruby or\n"
    db "Sapphire to receive a special\n"
    db  "Pokémon.\0"

DeliveryInProcess:: ; 1a0d
    db "Pokémon delivery in Process...\0"
        
TicketDelivered:: ; 1a2f
    db "Pokémon delivered!\n"
    db "\n"
    db "Press the A Button to resend.\n"
    db "Press the B Button to cancel.\0"
