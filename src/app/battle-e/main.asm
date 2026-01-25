SECTION "app/battle-e/main", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/erapi.asm"

dstruct ER_CustomBackground, \
  BackdropSpriteData, \
    .TilePtr=BattleTrainerBackdrop, \
    .PalettePtr=BackdropPalettes, \
    .MapPtr=BackdropTilemap, \
    .TileCount=40, \
    .PaletteCount=4

dstruct ER_CustomSprite, \
  DoorSpriteData, \
    .TilePtr=DoorSprite, \
    .PalettePtr=DoorPalette, \
    .Width=4, \
    .Height=8, \
    .FramesPerBank=1, \
    .Unknown=1, \
    .HitBoxWidth=1, \
    .HitBoxHeight=1, \
    .FrameCount=1

Instructions1: ; 178c
    db "Link e-Reader to Pokémon Ruby or \n"
    db "Sapphire and select MYSTERY EVENTS\n"
    db "on the game's main menu.\n"
    db "Press the B Button to cancel.\0"

Instructions2: ; 1808
    db "Press the A Button on the Game Boy\n"
    db "Advance containing Pokémon Ruby or\n"
    db "Sapphire to begin the Battle Entry.\0"

BattleEntryInProcess: ; 1872
    db "Battle Entry in Process...\0"

BattleEntryFinished: ; 188d
    db "Battle Entry finished!\n"
    db "\n"
    db "Press the A Button to resend.\n"
    db "Press the B Button to cancel.\0"

INCLUDE "common/battle_e_transfer.asm"

DEF DoorPaletteIdx EQU 129
DEF LeftDoorXPos EQU 104
DEF LeftDoorOpenXPos EQU (LeftDoorXPos - 32)
DEF RightDoorXPos EQU 136
DEF RightDoorOpenXPos EQU (RightDoorXPos + 32)
DEF DoorYPos EQU 64

DEF TrainerPaletteIdx EQU 128
DEF TrainerXPos EQU 119
DEF TrainerYPos EQU 64
DEF DoorOpenDuration EQU 32

Open_Doors: ; 1946
    ER_SetSpritePosAnimatedDuration LeftDoorSpriteHandle, LeftDoorOpenXPos, DoorYPos, DoorOpenDuration
    ER_SetSpritePosAnimatedDuration RightDoorSpriteHandle, RightDoorOpenXPos, DoorYPos, DoorOpenDuration
    ret

Close_Doors: ; 1965
    ER_SetSpritePosAnimatedDuration LeftDoorSpriteHandle, LeftDoorXPos, DoorYPos, DoorOpenDuration
    ER_SetSpritePosAnimatedDuration RightDoorSpriteHandle, RightDoorXPos, DoorYPos, DoorOpenDuration
    ret

Start:: ; 1984
    SuppressPauseScreen

    ; Load the background on layer 0
    ER_LoadCustomBackground BackdropSpriteData, 0
    ; Clear garbage in the text area
    ER_FillBackgroundTile 0, 0, 0, 14, 30, 6, 0

    ; Load the background on layer 1
    ; Pretty sure this is to allow the doors to be covered by their frame
    ER_LoadCustomBackground BackdropSpriteData, 1
    ; Clear the garbage in the text area
    ER_FillBackgroundTile 0, 0, 0, 14, 30, 6, 1

    ; Clear the door area on layer 0
    ER_FillBackgroundTile 0, 0, 11, 4, 8, 8, 0

    ; [202FD2Ch+122h]=4
    ld a, $4
    ER_API ER_ID_Unk0AE

    ; Create and position the trainer sprite
    ER_SpriteCreate TrainerSpriteHandle, TrainerPaletteIdx, TrainerSpriteData
    ER_SetSpritePos TrainerSpriteHandle, TrainerXPos, TrainerYPos

    ; Create and position the doors, this is done with 2 door sprites
    ER_SpriteCreate LeftDoorSpriteHandle, DoorPaletteIdx, DoorSpriteData
    ER_SpriteCreate RightDoorSpriteHandle, DoorPaletteIdx, DoorSpriteData
    ER_SpriteMirrorToggle LeftDoorSpriteHandle, ER_SpriteMirrorToggle_Horizontal
    ER_SetSpritePos LeftDoorSpriteHandle, LeftDoorXPos, DoorYPos
    ER_SetSpritePos RightDoorSpriteHandle, RightDoorXPos, DoorYPos

    ; Create textbox and initialize the settings
    CreateRegion TextboxHandlePtr, 30, 6, 0, 14, 0, 3
    ER_SetTextSizeA ER_SetTextSize_Small ; Handle still in a from CreateRegion
    ER_IncreaseTextKerning TextboxHandlePtr, 1, 2
    SetTextColor TextboxHandlePtr, 3, 0

    ; Fade in over 16 frames
    ER_FadeIn 16
    wait 16

    ; Unk
    ER_API ER_ID_Unk0C6

    ; Draw the first set of instrucion text
    DrawText TextboxHandlePtr, Instructions1, 8, 4

    ; Unk
    ER_API ER_ID_Unk08D

INCLUDE "common/wait_for_link.asm"

    call Open_Doors
    DrawText TextboxHandlePtr, Instructions2, 8, 4
    ER_API ER_ID_Unk08D
    and [hl]
    ld [bc], a

DEF UNKNOWN_VALUE EQU $02A6
INCLUDE "common/wait_for_ready.asm"

    call Close_Doors
    DrawText TextboxHandlePtr, BattleEntryInProcess, 8, 4

DEF DATA_TRANSFER_LENGTH EQU 6144
INCLUDE "common/transfer_data.asm"

    ld hl, $5fff
    ld_ind_hl Space_1
    ER_API_0C7 Space_1

    LD_HL_IND TrainerSpriteHandle
    ER_API ER_ID_SpriteHide
    wait 128
    call Open_Doors

    DrawText TextboxHandlePtr, BattleEntryFinished, 8, 4
    ER_API ER_ID_Unk08D

    ld c, a
    nop

INCLUDE "common/wrap_up.asm"
INCLUDE "common/word_shift_right.asm"

SomeVar1: ds 1              ; 1B9F
SomeVar2: ds 2              ; 1BA0
TextboxHandlePtr: ds 1      ; 1BA2
LeftDoorSpriteHandle: ds 2  ; 1BA3
RightDoorSpriteHandle: ds 2 ; 1BA5
TrainerSpriteHandle: ds 2   ; 1BA7

EOF_OFFSET $0A
