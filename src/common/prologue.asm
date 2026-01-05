SECTION "common/prologue", ROM0
INCLUDE "constants/regions.asm"

Prologue::
    db "GameFreak inc."
    db 0,0,0,0,0,0
    db $78,$56,$34,$12,$56,$AD,$95,$BF,$FF
    ; Text "e reader" ; no string terminator
    db 0,0,0,0,0,0,0,$01,$55
    db 0,0,0,0
    db REGION
    db 0
    db "GameFreak inc."
    db 0,0
