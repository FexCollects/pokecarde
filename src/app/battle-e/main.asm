SECTION "app/battle-e/main", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/erapi.asm"

BackdropSpriteData: ; 1777
    dw BattleTrainerBackdrop
    dw BackdropPalettes
    dw BackdropTilemap
    db $28,$00,$04,$00
DoorSpriteData: ; 1781
    dw DoorSprite
    dw DoorPalette
    db $04,$08,$01,$01,$01,$01,$01

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
    API $03B

    pop bc
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $00A8
    LD_HL_IND RightDoorSpriteHandle
    API $03B

    pop bc
    ret

Close_Doors: ; 1965
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $0068
    LD_HL_IND LeftDoorSpriteHandle
    API $03B

    pop bc
    ld l, $20
    push hl
    ld bc, $0040
    ld de, $0088
    LD_HL_IND RightDoorSpriteHandle
    API $03B

    pop bc
    ret

Start:: ; 1984
    SuppressPauseScreen

        ; Load the background on layer 0
    LoadCustomBackground BackdropSpriteData, 0
        ; Clear garbage in the text area
        TileFillBackground 0, 0, 0, 14, 30, 6, 0

        ; Load the background on layer 1
        ; Pretty sure this is to allow the doors to be covered by their frame
    LoadCustomBackground BackdropSpriteData, 1
        ; Clear the garbage in the text area
        TileFillBackground 0, 0, 0, 14, 30, 6, 1

        ; Clear the door area on layer 0
        TileFillBackground 0, 0, 11, 4, 8, 8, 0

    ld a, $4
    API $0AE

    CreateCustomSprite TrainerSpriteHandle, $80, TrainerSpriteData
    SetSpritePos TrainerSpriteHandle, 119, 64

    CreateCustomSprite LeftDoorSpriteHandle, $81, DoorSpriteData
    CreateCustomSprite RightDoorSpriteHandle, $81, DoorSpriteData
    SpriteMirrorToggle $01, LeftDoorSpriteHandle
    SetSpritePos LeftDoorSpriteHandle, 104, 64
    SetSpritePos RightDoorSpriteHandle, 136, 64

    CreateRegion RegionHandlePtr, 30, 6, 0, 14, 0, 3
    ld h, a
    ld l, $00
    SetTextSize
        IncreaseTextKerning RegionHandlePtr, 01, 02
    SetTextColor RegionHandlePtr, 3, 0

    FadeIn 16
    wait 16
    API $0C6
    DrawText RegionHandlePtr, Instructions1, 8, 4
    API $08D

INCLUDE "common/wait_for_link.asm"

    call Open_Doors
    DrawText RegionHandlePtr, Instructions2, 8, 4
    API $08D
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
    API_0C7 Space_1

    LD_HL_IND TrainerSpriteHandle
    API $047
    wait 128
    call Open_Doors

    DrawText RegionHandlePtr, BattleEntryFinished, 8, 4
    API $08D

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
