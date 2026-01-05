SECTION "common/prologue.corrupt", ROM0
INCLUDE "constants/regions.asm"
INCLUDE "include/charmaps.asm"


Prologue::
    db "GameFreak inc."
    db 0,0,0,0,0,0

    ; Corrupted version of the text "e reader"
    db $78,$56,$34,$12,$56,$AD,$95,$BF,$FF,0,0,0

    db 0,0,0,0,$01,$55
    db 0,0,0,0
    db REGION
    db 0
    db "GameFreak inc."
    db 0,0
