SECTION "app/event/00-R000", ROM0
INCLUDE "include/charmaps.asm"

SpriteData::
	dw TicketSprite,TicketPalette
	db $15,$08,$01,$01,$01,$01,$01 ; width 21, height 8

Instructions1:: ; 1921
	db "Link e-Reader to Pokémon Ruby or \n"
	db "Sapphire and select MYSTERY EVENTS\n"
	db "on the game's main menu.\n"
	db "Press the B Button to cancel.\0"

Instructions2:: ; 199d
	db "Press the A Button on the Game Boy\n"
	db "Advance containing Pokémon Ruby or\n"
	db "Sapphire to receive a commemorative\n"
	db "ribbon.\0"

DeliveryInProcess:: ; 1a0d
	db "Ribbon delivery in Process...\0"
        
TicketDelivered:: ; 1a2f
	db "Ribbons delivered!\n"
	db "\n"
	db "Press the A Button to resend.\n"
	db "Press the B Button to cancel.\0"
