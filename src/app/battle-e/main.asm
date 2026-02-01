SECTION "app/battle-e/main", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/gfapi.asm"

DEF LINKED_UP_SONG EQU $02A6
DEF APP_EXITED_SOUND EQU $0006

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

; SomeVar1 = CopiedToTXBufferCount
; SomeVar2 = NextByteToTX
; Space_1 = TXBufferStart
; Space_2 = TXBufferOffset1

; vvvvv INCLUDE "common/battle_e_transfer.asm" vvvvvv
; tx per is either 8 or 16
TransferData: ; hl = address of buffer, de = transfer_length
    ld_ind_hl SomeVar2 ; ld [SomeVar2], Address of buffer
    push de ; stack = transfer size
    ld hl, $BBBB
    ld_ind_hl Space_1 ; ld [Space_1], $BBBB
    EX_DE_HL ; hl = transfer_length, de = $BBBB
    ld_ind_hl Space_2 ; ld [Space_2], transfer length
        ; store transfer length in Space_2, which is odd, ; we are telling the gba how many bytes to expect
        ; because we never refer to it again
    ER_SIOWrite Space_1 ; transfer $BBBB, transfer size, 6 words of zero (first write would clear)

    wait 1
    pop hl ; number of bytes to transfer

    ; calculate number of words to transfer:
    ; de = (hl + 1) >> 1
    inc hl
    ld b, 1
    call WordShiftRight
    EX_DE_HL

.while_words_left_to_tx
    ld a, e
    or d
    ret z ; function end
    ; while de > 0…

    ld hl, $8888
    ld_ind_hl Space_1 ; ld [Space_1], $8888
    ld a, $01
    LD_IND_A SomeVar1 ; ld [SomeVar1], 1

; Copies 8 words from source buffer to transfer buffer
; while keeping count of the words left to transfer and
; the pointer to the next untransferred byte
.copy_8_words_to_tx_buffer
    LD_A_IND SomeVar1 ; ld a, [SomeVar1]
    cp $08
    jr nc, .do_transfer ; if a >= 8, goto do_transfer

    ; stash away the words left to transfer
    push de

    ; load the word to transfer from the src buffer into c,b
    LD_HL_IND SomeVar2 ; ld hl, [SomeVar2]
    ld c, [hl] ; c = first byte of the data left to transfer (c = *buff_next)
    inc hl ; hl = next location (buff_next++)
    ld b, [hl]; b = second byte of the data left to transfer (b = *buff_next)
    inc hl ; hl = next location (buff_next++)
    ld_ind_hl SomeVar2 ; ld [SomeVar2], buff_next

    ; Calculate the offset pointer to write into
    ld hl, SomeVar1 ; hl = &SomeVar1
    ld l, [hl] ; l = *SomeVar1
    ld h, $00
    add hl, hl ; hl = $00XX * 2
    ld de, Space_1 ; de = &Space_1
    add hl, de ; hl = hl + de, hl is a pointer set SomeVar1*2 bytes past Space_1

    ; Write the word c,b into the offset buffer
    ld [hl], c ; first byte is written into offset address
    inc hl ; next addr
    ld [hl], b ; second byte is written into offset address

    ; restore words left to transfer
    pop de
    ; transfer count goes down by 1
    dec de

    ; if words left to transfer == 0 jump
    ld a, e
    or d
    jr z, .do_transfer

    ; SomeVar1++
    ld hl, SomeVar1 ; hl = &SomeVar1
    ld a, $01
    add a, [hl] ; a = *SomeVar1 + 1
    ld [hl], a ; *SomeVar1 = a

    ; Copy the next word
    jr .copy_8_words_to_tx_buffer

.do_transfer ; if SomeVar1 > 8
    ; stash away the words left to transfer
    push de

    ; do the transfer
    ER_SIOWrite Space_1

    ; wait a frame
    wait 1

    ; restore words left to transfer
    pop de

    ; queue up the next 8 words
    jr .while_words_left_to_tx
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

    ; Start the process of making a multiplayer link
    ER_InitializeSIO

    ; Draw the first set of instrucion text
    DrawText TextboxHandlePtr, Instructions1, 8, 4

    ER_PlayStaticSystemSound $00D8

;vvvvvvvvvvv INCLUDE "common/wait_for_link.asm" vvvvvvvvvvvvvvvvvv
    wait 32

    ER_ConfigureSIO $02, $B9A0, $0076, $08

.wait_for_link_initialized
    ER_GetSIOLinkStatus

    ; if initializing jump to .wait_and_update
    cp ER_GetSIOLinkStatus_Initializing
    jr z, .wait_and_update

    ER_GetSIOLinkStatus
    ; if a != 0, jump to .wait_for_linked
    or a
    jr nz, .wait_for_linked
.wait_and_update
    waita 1
    ER_UpdateSIOLinkStatus
    jr .wait_for_link_initialized

.wait_for_linked
    waita 1

    ; if the user presses B while waiting for linked
    ; give up and exit to the menu
    GF_JumpIfNotPressed ER_KEY_B, .check_if_linked
    GF_PlaySystemSoundThenExit APP_EXITED_SOUND, ER_Exit_Menu

.check_if_linked
    ER_GetSIOConnectedStatus
    ; if A < 2, loop back to waiting
    cp 2
    jr c, .wait_for_linked

.link_established

;^^^^^^^^^^^^^^^^^^^^^^^^^ wait for link ^^^^^^^^^^^^^^^^^^^^^^^^^

    call Open_Doors
    DrawText TextboxHandlePtr, Instructions2, 8, 4

    ER_PlayStaticSystemSound LINKED_UP_SONG

;vvvvvvvvvvvvv INCLUDE "common/wait_for_ready.asm" vvvvvvvvvvvvvvvv
.wait_for_ready
    waita $01

    ; Read and save the status2 to Space_5
    ER_GetSIOConnectedStatus2
    ld l, a
    ld h, $00
    ld_ind_hl Space_5 ; ld [Space_5], $00XX

    ; if Status >= 2, keep going
    ER_GetSIOConnectedStatus
    cp $02
    jr nc, .check_status_3_4

    ; otherwise something went wrong. Should be connected but we aren't
    ; Restart the application
    ER_PauseSong LINKED_UP_SONG
    GF_PlaySystemSoundThenExit APP_EXITED_SOUND, ER_Exit_Restart

.check_status_3_4
    ; Restore the value ($00XX) from ER_GetSIOConnectedStatus2
    LD_HL_IND Space_5 ; ld hl, [Space_5]
    ld a, l ; a = $XX
    sub $04 ; a = a - 4
    or h    ; a = a or 0
    jr z, .link_ready ; if Space_5 == 4, goto .link_ready

    ; Restore the value ($00XX) from ER_GetSIOConnectedStatus2
    LD_HL_IND Space_5 ; ld hl, [Space_5]
    ld a, l ; a = $XX
    sub $03 ; a = a - 3
    or h    ; a = a or 0
    jr nz, .wait_for_ready ; if Space_5 != 3, goto .wait_for_ready
.link_ready
;^^^^^^^^^^^^^^^^^^^^^^^^^ wait for ready ^^^^^^^^^^^^^^^^^^^^^^^^^

    call Close_Doors
    DrawText TextboxHandlePtr, BattleEntryInProcess, 8, 4
    ER_FadeOutSong LINKED_UP_SONG, $0040

DEF DATA_TRANSFER_LENGTH EQU 6144

;vvvvvvvvvv INCLUDE "common/transfer_data.asm" vvvvvvvvvvvvvvvvvvv
.do_sio_initial_read
    waita 1

    ER_SIORead Space_3
    or a ; a = a or a
    jr nz, .sio_read_okay ; a != 0, goto .sio_read_okay

    GF_PlaySystemSoundThenExit APP_EXITED_SOUND, ER_Exit_Restart

.sio_read_okay
    ; load the value returned in Space_3 to hl
    LD_HL_IND Space_3 ; ld hl, [Space_3]
    ; and make a copy of it in Space_4
    ld_ind_hl Space_4 ; ld [Space_4], hl

    ld a, l
    cp $22
    jr nz, .do_sio_initial_read

    ld a, h
    cp $22
    jr nz, .do_sio_initial_read

    ; if hl != $2222 try initial read again
    ; otherwise start the transfer
    ; $2222 is the link message from the GBA

    ld de, 60 ; prologue transfer length
    ld hl, Prologue
    call TransferData

    ld de, DATA_TRANSFER_LENGTH ; payload transfer length
    ld hl, DataPacket
    call TransferData
;^^^^^^^^^^^^^^^^^^^^^^^^^ transfer data ^^^^^^^^^^^^^^^^^^^^^^^^^

    ; Write $5fff. signal end of transmission?
    ld hl, $5fff
    ld_ind_hl Space_1 ; ld [Space_1], $5fff
    ER_SIOWrite Space_1

    ; Hide the sprite
    ER_SpriteHide TrainerSpriteHandle
    wait 128
    ; Open the doors
    call Open_Doors
    ; Draw the final set of instructions
    DrawText TextboxHandlePtr, BattleEntryFinished, 8, 4
    ; Play a sound
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
