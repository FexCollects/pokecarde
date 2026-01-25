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
    ER_API ER_ID_Unk0DB ; A=[3003E51h]

    ; if a is $01 jump to .asm_1b6f
    cp $01
    jr z, .asm_1b6f

    ER_API ER_ID_Unk0DB ; A=[3003E51h]
    or a ; update the z flag without changing a?
    jr nz, .asm_1b76 ; if a is not zero, jump 1b76
.asm_1b6f ; no link seen? so wait a frame and try again?
    waita $01
    ER_API ER_ID_Unk0C5
    jr .asm_1b64

.asm_1b76 ; not one and not zero?
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
