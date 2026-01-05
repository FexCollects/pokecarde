SECTION "common/prologue", ROM0
INCLUDE "constants/regions.asm"
INCLUDE "include/charmaps.asm"


Prologue::
    db "GameFreak inc."
    db 0,0,0,0,0,0

PUSHC gen3text
    db 0,0,0,0
    db "e reader"
POPC

    db 0,0,0,0,$01,$55
    db 0,0,0,0
    db REGION
    db 0
    db "GameFreak inc."
    db 0,0
