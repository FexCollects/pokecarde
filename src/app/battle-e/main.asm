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

Open_Doors: ; 1946
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $0048
    LD_HL_IND LeftDoorSpriteHandle
    ER_API ER_ID_Unk03B

    pop bc
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $00A8
    LD_HL_IND RightDoorSpriteHandle
    ER_API ER_ID_Unk03B

    pop bc
    ret

Close_Doors: ; 1965
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $0068
    LD_HL_IND LeftDoorSpriteHandle
    ER_API ER_ID_Unk03B

    pop bc
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $0088
    LD_HL_IND RightDoorSpriteHandle
    ER_API ER_ID_Unk03B

    pop bc
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

    ld a, $4
    ER_API ER_ID_Unk0AE

    ER_SpriteCreate TrainerSpriteHandle, $80, TrainerSpriteData
    ER_SetSpritePos TrainerSpriteHandle, 119, 64

    ER_SpriteCreate LeftDoorSpriteHandle, $81, DoorSpriteData
    ER_SpriteCreate RightDoorSpriteHandle, $81, DoorSpriteData
    ER_SpriteMirrorToggle $01, LeftDoorSpriteHandle
    ER_SetSpritePos LeftDoorSpriteHandle, 104, 64
    ER_SetSpritePos RightDoorSpriteHandle, 136, 64

    CreateRegion RegionHandlePtr, 30, 6, 0, 14, 0, 3
    ld h, a
    ld l, $00
    SetTextSize
    IncreaseTextKerning RegionHandlePtr, 01, 02
    SetTextColor RegionHandlePtr, 3, 0

    ER_FadeIn 16
    wait 16
    ER_API ER_ID_Unk0C6
    DrawText RegionHandlePtr, Instructions1, 8, 4
    ER_API ER_ID_Unk08D

INCLUDE "common/wait_for_link.asm"

    call Open_Doors
    DrawText RegionHandlePtr, Instructions2, 8, 4
    ER_API ER_ID_Unk08D
    and [hl]
    ld [bc], a
    
DEF UNKNOWN_VALUE EQU $02A6
INCLUDE "common/wait_for_ready.asm"

    call Close_Doors
    DrawText RegionHandlePtr, BattleEntryInProcess, 8, 4

DEF DATA_TRANSFER_LENGTH EQU 6144
INCLUDE "common/transfer_data.asm"

    ld hl, $5fff
    ld_ind_hl Space_1
    ER_API_0C7 Space_1

    LD_HL_IND TrainerSpriteHandle
    ER_API ER_ID_SpriteHide
    wait 128
    call Open_Doors

    DrawText RegionHandlePtr, BattleEntryFinished, 8, 4
    ER_API ER_ID_Unk08D

    ld c, a
    nop

INCLUDE "common/wrap_up.asm"
INCLUDE "common/word_shift_right.asm"

SomeVar1: db                ; 1B9F
SomeVar2: dw                ; 1BA0
RegionHandlePtr: db         ; 1BA2
LeftDoorSpriteHandle: dw    ; 1BA3
RightDoorSpriteHandle: dw   ; 1BA5
TrainerSpriteHandle: dw     ; 1BA7

EOF_OFFSET $0A
