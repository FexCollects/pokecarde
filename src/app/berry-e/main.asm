SECTION "app/berry-e/main", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/erapi.asm"

BackgroundSpriteData:
    dw BackgroundSprite, BackgroundPalette, BackgroundTilemap
    db $05,$00,$01,$00
BerrySpriteData:
    dw BerrySprite, BerryPalette 
    db $06,$06,$01,$01,$01,$01,$01

Instructions1: ; B65
    db "Link e-Reader to Pokémon Ruby or \n"
    db "Sapphire and select MYSTERY EVENTS\n"
    db "on the game's main menu.\n"
    db "Press the B Button to cancel.\0"
Instructions2: ; BE1
    db "Press the A Button on the Game Boy\n"
    db "Advance containing Pokémon Ruby or\n"
    db "Sapphire to send a BERRY.\0"
BerrySendingInProcess: ; C41
    db "BERRY sending in Process...\0"
ABerryWasSent: ; C5D
    db "A BERRY was sent.\n"
    db "\n"
    db "Press the A Button to resend.\n"
    db "Press the B Button to cancel.\0"

INCLUDE "common/battle_e_transfer.asm"

AfterTransfer:
    ld hl, $5FFF
    LD_IND_HL Space_1
    ld hl, Space_1
    API $0C7

    wait $01
    ret

Start::
    SuppressPauseScreen
    LoadCustomBackground BackgroundSpriteData, 0
        TileFillBackground 0, 0, 0, 14, 30, 6, 0

    CreateCustomSprite SpriteHandlePtr, $80, BerrySpriteData
    SetSpritePos SpriteHandlePtr, 376, 56

    CreateRegion RegionHandlePtr, 30, 6, 0, 14, 0, 4
    ld h, a
    ld l, $00
    SetTextSize
        IncreaseTextKerning RegionHandlePtr, 01, 02
    SetTextColor RegionHandlePtr, 2, 0
    SetRegionColor RegionHandlePtr, 0
    SetBackgroundPalette $10, $0040, UnknownPalette

    FadeIn 16
    wait 16
    API $0C6

    DrawText RegionHandlePtr, Instructions1, 8, 4
    API $08D

INCLUDE "common/wait_for_link.asm"

    API_084 SpriteHandlePtr, 120, 56, 16 ; sprite move and fade in?
    pop bc
    API $08D
    push af
    nop

    DrawText RegionHandlePtr, Instructions2, 8, 4

DEF UNKNOWN_VALUE EQU $00F5
INCLUDE "common/wait_for_ready.asm"

    DrawText RegionHandlePtr, BerrySendingInProcess, 8, 4

DEF DATA_TRANSFER_LENGTH EQU 3072
INCLUDE "common/transfer_data.asm"

    call AfterTransfer

    wait 128
    API $08D

    ld c, a
    nop
    API_084 SpriteHandlePtr, $FF78, 56, 16 ; sprite move and fade out?

    pop bc
    DrawText RegionHandlePtr, ABerryWasSent, 8, 4

INCLUDE "common/wrap_up.asm"

INCLUDE "common/word_shift_right.asm"

SomeVar1: db          ; EFA
SomeVar2: dw          ; EFB
RegionHandlePtr: db   ; EFD
SpriteHandlePtr: dw   ; EFE

EOF_OFFSET $06
