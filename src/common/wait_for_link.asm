    ret c
    nop
    wait 32
    ld l, $02
    push hl
    ld bc, $B9A0
    ld de, $0076
    ld a, $08
    ER_API ER_ID_Unk0C4
    pop bc
.asm_1b64
    ER_API ER_ID_Unk0DB

    cp $01
    jr z, .asm_1b6f
    ER_API ER_ID_Unk0DB
    or a
    jr nz, .asm_1b76
.asm_1b6f
    waita $01
    ER_API ER_ID_Unk0C5
    jr .asm_1b64

.asm_1b76
    waita $01
    LD_HL_IND $00C2
    ld a, l
    and $02
    jr z, .asm_1b90

    IS_SOUND_PLAYING 2 ; exit

.asm_1b90
    ER_API ER_ID_Unk0CA
    cp $02
    jr c, .asm_1b76
