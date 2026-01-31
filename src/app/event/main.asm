SECTION "app/event/main", ROM0
INCLUDE "include/gfapi.asm"

; this function is subtly different than the one
; on the Battle e cards, for no apparent reason
TransferData:
    ld_ind_hl SomeVar1
    push de
    ld hl, $bbbb
    ld_ind_hl Space_1
    EX_DE_HL
    ld_ind_hl Space_2
    ER_API_0C7 Space_1

    wait $01
    pop hl
    inc hl
    ld b, $01
    call WordShiftRight

    ld_ind_hl SomeVar2
.asm_1aa1
    LD_HL_IND SomeVar2
    ld a, l
    or h
    ret z

    ld hl, $8888
    ld_ind_hl Space_1
    ld e, $01

.asm_1aaf
    ld a, e
    cp $08
    jr nc, .asm_1ad9

    push de
    LD_HL_IND SomeVar1
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld_ind_hl SomeVar1
    ld l, e
    ld h, $00
    add hl, hl
    ld de, Space_1
    add hl, de
    ld [hl], c
    inc hl
    ld [hl], b
    pop de
    LD_HL_IND SomeVar2
    dec hl
    ld_ind_hl SomeVar2
    ld a, l
    or h
    jr z, .asm_1ad9

    inc e
    jr .asm_1aaf

.asm_1ad9
    ER_API_0C7 Space_1
    wait $01
    jr .asm_1aa1

Start:: ; 1ae2
    SuppressPauseScreen

    ER_SpriteCreate SpriteHandlePtr, $80, SpriteData
    ER_SetSpritePos SpriteHandlePtr, 120, 64
    ER_SpriteHide SpriteHandlePtr

    CreateRegion RegionHandlePtr, 30, 6, 0, 14, 0, 4
    ER_SetTextSizeA ER_SetTextSize_Small ; Handle still in a from CreateRegion

    ER_IncreaseTextKerning RegionHandlePtr, 1, 2
    SetTextColor RegionHandlePtr, 2, 0
    SetRegionColor RegionHandlePtr, 0
    SetBackgroundPalette 16, $0040, TicketPalette

    ER_FadeIn 16
    wait 16

    ER_API ER_ID_Unk0C6

    DrawText RegionHandlePtr, Instructions1, 8, 4
    ER_PlayStaticSystemSound $00D8

INCLUDE "common/wait_for_link.asm"

    ER_SpriteShow SpriteHandlePtr

    DrawText RegionHandlePtr, Instructions2, 8, 4

    ER_PlayStaticSystemSound $0078

DEF UNKNOWN_VALUE EQU $0078
INCLUDE "common/wait_for_ready.asm"

    DrawText RegionHandlePtr, DeliveryInProcess, 8, 4

DEF DATA_TRANSFER_LENGTH EQU 6144
INCLUDE "common/transfer_data.asm"
    ld hl, $5fff
    ld_ind_hl Space_1
    ER_API_0C7 Space_1

    wait $80

    ER_SpriteHide SpriteHandlePtr

    DrawText RegionHandlePtr, TicketDelivered, 8, 4

    ER_PlayStaticSystemSound $004F

INCLUDE "common/wrap_up.asm"

INCLUDE "common/word_shift_right.asm"

SomeVar1: ds 2 ; 1CA2
RegionHandlePtr: ds 1 ; 1CA4
SpriteHandlePtr: ds 2 ; 1CA5
SomeVar2: ds 2 ; 1CA7

; Stripping metadata. How many bytes above this
; byte should be stripped.
EOF_OFFSET $07
