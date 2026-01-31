SECTION "app/berry-e/main", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/gfapi.asm"

dstruct ER_CustomBackground, \
  BackgroundSpriteData, \
    .TilePtr=BackgroundSprite, \
    .PalettePtr=BackgroundPalette, \
    .MapPtr=BackgroundTilemap, \
    .TileCount=5, \
    .PaletteCount=1

dstruct ER_CustomSprite, \
  BerrySpriteData, \
    .TilePtr=BerrySprite, \
    .PalettePtr=BerryPalette, \
    .Width=6, \
    .Height=6, \
    .FramesPerBank=1, \
    .Unknown=1, \
    .HitBoxWidth=1, \
    .HitBoxHeight=1, \
    .FrameCount=1

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
    ld_ind_hl Space_1
    ld hl, Space_1
    ER_API ER_ID_Unk0C7

    wait $01
    ret

Start::
    SuppressPauseScreen
    ER_LoadCustomBackground BackgroundSpriteData, 0
    ER_FillBackgroundTile 0, 0, 0, 14, 30, 6, 0

    ER_SpriteCreate SpriteHandlePtr, $80, BerrySpriteData
    ER_SetSpritePos SpriteHandlePtr, 376, 56

    CreateRegion RegionHandlePtr, 30, 6, 0, 14, 0, 4
    ER_SetTextSizeA ER_SetTextSize_Small ; Handle still in a from CreateRegion
    ER_IncreaseTextKerning RegionHandlePtr, 01, 02
    SetTextColor RegionHandlePtr, 2, 0
    SetRegionColor RegionHandlePtr, 0
    SetBackgroundPalette $10, $0040, UnknownPalette

    ER_FadeIn 16
    wait 16
    ER_API ER_ID_Unk0C6

    DrawText RegionHandlePtr, Instructions1, 8, 4
    ER_PlayStaticSystemSound $00D8

INCLUDE "common/wait_for_link.asm"

    ER_API_084 SpriteHandlePtr, 120, 56, 16 ; sprite move and fade in?
    pop bc

    ER_PlayStaticSystemSound $00F5

    DrawText RegionHandlePtr, Instructions2, 8, 4

DEF UNKNOWN_VALUE EQU $00F5
INCLUDE "common/wait_for_ready.asm"

    DrawText RegionHandlePtr, BerrySendingInProcess, 8, 4

DEF DATA_TRANSFER_LENGTH EQU 3072
INCLUDE "common/transfer_data.asm"

    call AfterTransfer

    wait 128
    ER_PlayStaticSystemSound $004F

    ER_API_084 SpriteHandlePtr, $FF78, 56, 16 ; sprite move and fade out?

    pop bc
    DrawText RegionHandlePtr, ABerryWasSent, 8, 4

INCLUDE "common/wrap_up.asm"

INCLUDE "common/word_shift_right.asm"

SomeVar1: db          ; EFA
SomeVar2: dw          ; EFB
RegionHandlePtr: db   ; EFD
SpriteHandlePtr: dw   ; EFE

EOF_OFFSET $06
