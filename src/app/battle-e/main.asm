SECTION "app/battle-e/main", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/gfapi.asm"

DEF LINKED_UP_SONG EQU $02A6

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

; vvvvv INCLUDE "common/battle_e_transfer.asm" vvvvvv
TransferData:
    ld_ind_hl SomeVar2
    push de
    ld hl, $BBBB
    ld_ind_hl Space_1 ; Space_1 = $BBBB
    EX_DE_HL
    ld_ind_hl Space_2 ; store transfer length in Space_2, which is odd,
              ; because we never refer to it again
    ER_API_0C7 Space_1

    wait 1
    pop hl ; number of bytes to transfer

    ; calculate number of words to transfer:
    ; de = (hl + 1) >> 1
    inc hl
    ld b, 1
    call WordShiftRight
    EX_DE_HL

.asm_18FE
    ld a, e
    or d
    ret z
    ; while de > 0…

    ld hl, $8888
    ld_ind_hl Space_1 ; Space_1 = $8888
    ld a, $01
    LD_IND_A SomeVar1 ; SomeVar1 = 1

.asm_190C
    LD_A_IND SomeVar1 ; a = SomeVar1
    cp $08
    jr nc, .asm_193B

    push de
    LD_HL_IND SomeVar2
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld_ind_hl SomeVar2
    ld hl, SomeVar1
    ld l, [hl]
    ld h, $00
    add hl, hl
    ld de, Space_1
    add hl, de
    ld [hl], c
    inc hl
    ld [hl], b
    pop de
    dec de
    ld a, e
    or d
    jr z, .asm_193B

    ld hl, SomeVar1
    ld a, $01
    add a, [hl]
    ld [hl], a
    jr .asm_190C

.asm_193B ; if SomeVar1 > 8
    push de
    ER_API_0C7 Space_1 ; this must be the data transfer? it’s the only API function called

    wait 1
    pop de
    jr .asm_18FE
; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

    ; Set all new sprites to be drawn with priority 1, this causes them
    ; to be sandwiched between the two background layers allowing the
    ; doors to be hidden when they slide open
    ER_SetNewSpritePriority $04

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

    ; Some kind of init function.
    ; Needed to progress linking.
    ; Does a number of things
    ; never goes from 0 -> 1 without this.
    ; ER_SIO
    ER_API ER_ID_Unk0C6

    ; Draw the first set of instrucion text
    DrawText TextboxHandlePtr, Instructions1, 8, 4

    ER_PlayStaticSystemSound $00D8

;vvvvvvvvvvv INCLUDE "common/wait_for_link.asm" vvvvvvvvvvvvvvvvvv
    wait 32 ; wait for 32 frames, assuming to give 0C6 some time?

    ; Calling 0C4 with stack = $02 (h is empty?), bc = $B9A0, de = $0076, a = $08
    ld l, $02
    push hl
    ld bc, $B9A0
    ld de, $0076
    ld a, $08
    ER_API ER_ID_Unk0C4 ; Configure SIO? what is diferent between 0C6
    pop bc

; 00 = unintialized
; 01 = initializing
; 02 = initialized
; 04 = connected

; .loop
;  A = [3003E51h]
;  if A == $01:
;   jmp .service_loop
;  else:
;   A = [3003E51h]
;   A = A or A
;   if A != 0:
;     jmp .next
;   else:
;     jmp .service_loop
; .service_loop
;  wait 1 frame
;  [0300465h] = [3003E51h] if [0202949h] == 1 and [3003E51h] == 1
;  jmp .loop

.asm_1b64
    ; GetLinkStatus
    ER_API ER_ID_Unk0DB ; A=[3003E51h]

    ; if a is $01 jump to .asm_1b6f
    cp $01
    jr z, .asm_1b6f

    ; Maybe update ??
    ER_API ER_ID_Unk0DB ; A=[3003E51h]
    or a ; update the z flag without changing a?
    jr nz, .asm_1b76 ; if a is not zero, jump 1b76
.asm_1b6f ; no link seen? so wait a frame and try again?
    waita $01
    ER_API ER_ID_Unk0C5
    jr .asm_1b64

.asm_1b76 ; not one and not zero?
    waita $01 ; wait a frame

    ; if b was not pressed then loop
    GF_JumpIfNotPressed ER_KEY_B, .asm_1b90
    ; else exit
    GF_PlaySystemSoundThenExit $0006, ER_Exit_Menu

.asm_1b90
    ER_API ER_ID_Unk0CA ; returns 0 - 3 in A from a different variable.
    cp $02
    jr c, .asm_1b76 ; if A < 2, loop back to waiting

    ; if A >= 2, open door animation, show instructions. Games are linked at this point

;^^^^^^^^^^^^^^^^^^^^^^^^^ wait for link ^^^^^^^^^^^^^^^^^^^^^^^^^

    call Open_Doors
    DrawText TextboxHandlePtr, Instructions2, 8, 4

    ER_PlayStaticSystemSound LINKED_UP_SONG

;vvvvvvvvvvvvv INCLUDE "common/wait_for_ready.asm" vvvvvvvvvvvvvvvv
.asm_1baf
    waita $01
    ER_API ER_ID_Unk0DB

    ld l, a
    ld h, $00
    ld_ind_hl Space_5
    ER_API ER_ID_Unk0CA

    cp $02
    jr nc, .asm_1bd4

    ER_PauseSong LINKED_UP_SONG
    GF_PlaySystemSoundThenExit $0006, ER_Exit_Restart

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
;^^^^^^^^^^^^^^^^^^^^^^^^^ wait for ready ^^^^^^^^^^^^^^^^^^^^^^^^^

    call Close_Doors
    DrawText TextboxHandlePtr, BattleEntryInProcess, 8, 4
    ER_FadeOutSong LINKED_UP_SONG, $0040

DEF DATA_TRANSFER_LENGTH EQU 6144

;vvvvvvvvvv INCLUDE "common/transfer_data.asm" vvvvvvvvvvvvvvvvvvv
.asm_1bfe
    waita $01

    ld hl, Space_3 ; hl = &Space_3
    ER_API ER_ID_Unk0C8 ; reads from hl, returns in a. Space_3 is a pointer here. Does the runtime fill the pointer as a return??
    or a
    jr nz, .asm_1c18
    ; this seems like its checking for some error but idk

    GF_PlaySystemSoundThenExit $0006, ER_Exit_Restart

.asm_1c18
    LD_HL_IND Space_3 ; hl = *Space_3 ; sure looks like its returning via the pointer
    ; it also looks like maybe Space_3 is an array??
    ld_ind_hl Space_4 ; *Space_4 = hl
    ld a, l
    cp $22
    jr nz, .asm_1bfe

    ld a, h
    cp $22
    jr nz, .asm_1bfe

    ld de, 60 ; transfer length
    ld hl, Prologue
    call TransferData

    ld de, DATA_TRANSFER_LENGTH ; transfer length
    ld hl, DataPacket
    call TransferData
;^^^^^^^^^^^^^^^^^^^^^^^^^ transfer data ^^^^^^^^^^^^^^^^^^^^^^^^^

    ld hl, $5fff
    ld_ind_hl Space_1 ; *Space_1 = $5fff
    ER_API_0C7 Space_1 ; SIO_write 2*n bytes

    LD_HL_IND TrainerSpriteHandle
    ER_API ER_ID_SpriteHide
    wait 128
    call Open_Doors

    DrawText TextboxHandlePtr, BattleEntryFinished, 8, 4

    ER_PlayStaticSystemSound $004F

INCLUDE "common/wrap_up.asm"
INCLUDE "common/word_shift_right.asm"

SomeVar1: ds 1              ; 1B9F
SomeVar2: ds 2              ; 1BA0
TextboxHandlePtr: ds 1      ; 1BA2
LeftDoorSpriteHandle: ds 2  ; 1BA3
RightDoorSpriteHandle: ds 2 ; 1BA5
TrainerSpriteHandle: ds 2   ; 1BA7

EOF_OFFSET $0A
