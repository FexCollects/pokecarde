.asm_1baf
    waita $01
    ER_API ER_ID_Unk0DB

    ld l, a
    ld h, $00
    ld_ind_hl Space_5
    ER_API ER_ID_Unk0CA

    cp $02
    jr nc, .asm_1bd4

    ld hl, UNKNOWN_VALUE
    SOUND_PAUSE

    IS_SOUND_PLAYING 1 ; return

.asm_1bd4
    LD_HL_IND Space_5
    ld a, l
    sub $04
    or h
    jr z, .asm_1be6

    LD_HL_IND Space_5
    ld a, l
    sub $03
    or h
    jr nz, .asm_1baf
.asm_1be6
