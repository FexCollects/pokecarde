INCLUDE "../macros.asm"
INCLUDE "../constants/scriptcommands.asm"
INCLUDE "../constants/ribbons.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db COUNTRY_RIBBON 
	db MARINE_RIBBON ; Marine Ribbon
	db $28 ; description
	db $02 ; end of chunks

DataEnd:
	EOF
