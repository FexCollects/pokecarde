; some Z80 opcodes aren’t supported by Game Boy, 
; but are used in e-Reader programs

; ld [\1], hl
MACRO LD_IND_HL
    db $22, (\1 & $FF), (\1 >> 8)
    ENDM
; ld [\1], a
MACRO LD_IND_A
    db $32, (\1 & $FF), (\1 >> 8)
    ENDM

; ld hl, [\1]
MACRO LD_HL_IND
    db $2A, (\1 & $FF), (\1 >> 8)
    ENDM
; ld a, [\1]
MACRO LD_A_IND
    db $3A
    dw \1
    ENDM

MACRO waita
    ld a, \1
    db $76
    ENDM
; ld [hl], a
MACRO LD_IND_HL_A
    db $77
    ENDM

; ld a, [hl]
MACRO LD_IND_A_HL
    db $7E
    ENDM

; ld c, [hl]
MACRO LD_IND_C_HL
    db $4E
    ENDM

; ld b, [hl]
MACRO LD_IND_B_HL
    db $46
    ENDM

; ld l, [hl]
MACRO LD_IND_L_HL
    db $6E
    ENDM

; ld e, [hl]
MACRO LD_IND_E_HL
    db $5E
    ENDM

; ld d, [hl]
MACRO LD_IND_D_HL
    db $56
    ENDM

; ld [hl], c
MACRO LD_IND_HL_C
    db $71
    ENDM

; ld [hl], b
MACRO LD_IND_HL_B
    db $70
    ENDM

; ld a, [de]
MACRO LD_IND_A_DE
    db $1A
    ENDM

; add a, [hl]
MACRO ADD_A_HL_IND
    db $86
    ENDM

MACRO EX_DE_HL
    db $EB
    ENDM

MACRO wait
    db $D3, \1
    ENDM

DEF EOF_OFFSET EQUS "db"
