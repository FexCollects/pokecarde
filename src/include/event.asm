INCLUDE "include/gba.asm"
INCLUDE "constants/card_types.asm"
INCLUDE "constants/items.asm"
INCLUDE "constants/scriptcommands.asm"
INCLUDE "constants/regions.asm"

MACRO Mystery_Event
        CardHeader CHECKSUM_CRC
	dl 0 ; checksum placeholder
        ENDM

