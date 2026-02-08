SECTION "app/08-O001", ROM0
INCLUDE "include/charmaps.asm"
INCLUDE "include/gfapi.asm"

MACRO DG_SetTextSize ; handle, size
    LD_A_IND \1 ; a = *handle
    ld hl, \2   ; hl = $00XX
    or h        ; a = h | $00
    ld h,a      ; h = a
    ER_API ER_ID_SetTextSize
ENDM

MACRO DG_UpdateText ; Line1, Line2, Line3
    ld bc, \3
    ld de, \2
    ld hl, \1
    call UpdateText
ENDM

MACRO COPY_SELECTION_STR_INTO_BUF
    xor a
    LD_IND_A SelectedRegiTextPtr ; ld [\1], a
    ld hl,TransferDataSelection ; hl = &TransferDataSelection (selcted index from above)
    LD_IND_L_HL ; ld l, [hl]
    ld h,$00 ; hl = 00XX / index into array
    ld e,l
    ld d,h
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,de ; hl = hl * 9
    ld de,RegirockDollText ; de = &RegirockDollText
    add hl,de ; hl = hl + de
    EX_DE_HL ; de = hl;
    ld hl,SelectedRegiTextPtr ; ld = &SelectedRegiTextPtr
    call StringCat ; copy selected doll name into SelectedRegiTextPtr
ENDM

MACRO SET_PACKET_ID ; packet id
    ld hl, \1
    ld_ind_hl SIO_TX_PacketId ; ld [SIO_TX_PacketId], $\1
ENDM

DataPointers:
    dw DataStartRegirock
    dw DataStartRegice
    dw DataStartRegisteel

; hl = address of buffer, de = transfer_length
; returns in a: 1 ok, 0 error
TransferData:
    ld_ind_hl NextByteToTX ; ld [NextByteToTX], Address of buffer
    push de ; stack = transfer size
    SET_PACKET_ID $BBBB
    EX_DE_HL ; hl = transfer_length
    ; write the transfer length into the package so the gba knows what to expect
    ld_ind_hl SIO_TX_Buff ; ld [SIO_TX_Buff], transfer length
    ER_SIOWrite SIO_TX_PacketId ; transfer $BBBB, transfer size, 6 words of zero (first write would clear)

    wait 1
    pop hl ; number of bytes to transfer

    ; calculate number of words to transfer:
    ; *WordTransferCount = (hl + 1) >> 1
    inc hl
    ld b, 1
    call WordShiftRight
    ld_ind_hl WordTransferCount

.while_words_left_to_tx
    LD_HL_IND WordTransferCount ; hl = *WordTransferCount
    ld a,l
    or h
    jr z, .transfer_ret_ok ; if WordTransferCount == 0

    SET_PACKET_ID $8888

    ; initialize words copied to 1
    ld e, $01

; Copies 8 words from source buffer to transfer buffer
; while keeping count of the words left to transfer and
; the pointer to the next untransferred byte
.copy_8_words_to_tx_buffer
    ld a,e
    cp $08
    jr nc, .do_transfer ; if a >= 8, goto do_transfer

    ; stash away e, number of words copied. d garbage?
    push de

    ; load the word to transfer from the src buffer into c,b
    LD_HL_IND NextByteToTX ; ld hl, [NextByteToTX]
    ld c, [hl] ; c = first byte of the data left to transfer (c = *buff_next)
    inc hl ; hl = next location (buff_next++)
    ld b, [hl] ; b = second byte of the data left to transfer (b = *buff_next)
    inc hl ; hl = next location (buff_next++)
    ld_ind_hl NextByteToTX ; ld [NextByteToTX], buff_next

    ; Calculate the offset pointer to write into
    ld l,e
    ld h, $00
    add hl, hl ; hl = $00XX * 2
    ld de, SIO_TX_PacketId ; de = &SIO_TX_PacketId
    add hl, de ; hl = hl + de, hl is a pointer set CopiedToTXBufferCount*2 bytes past SIO_TX_PacketId

    ; Write the word c,b into the offset buffer
    ld [hl], c ; first byte is written into offset address
    inc hl ; next addr
    ld [hl], b ; second byte is written into offset address

    ; restore into e, number of words copied
    pop de

    ; transfer count goes down by 1
    LD_HL_IND WordTransferCount
    dec hl
    ld_ind_hl WordTransferCount

    ; if words left to transfer == 0 jump
    ld a,l
    or h
    jr z, .do_transfer

    ; CopiedToTXBufferCount++
    inc e

    ; Copy the next word
    jr .copy_8_words_to_tx_buffer

.do_transfer ; if CopiedToTXBufferCount > 8
    ; do the transfer
    ER_SIOWrite SIO_TX_PacketId

    ; if Status >= 2, keep going
    ER_GetSIOConnectedStatus
    cp $02
    jr nc, .do_transfer_1

    ; error occurred. a = 0, return
    xor a
    ret

.do_transfer_1:
    ER_SIORead SIO_RX_Buff
    or a
    jr nz, .do_transfer_2

    ; error occurred. a = 0, return
    xor a
    ret

.do_transfer_2:
    ; wait a frame
    wait $01

    ; queue up the next 8 words
    jr .while_words_left_to_tx

.transfer_ret_ok:
    ld a,$01
    ret

SendFinalPacket:
    SET_PACKET_ID $5FFF
    ER_SIOWrite SIO_TX_PacketId
    wait $01
    ret

WaitForGBALink:
    ; this is probably SIO reset
    ; to reset because we send multiple packets?
    ER_API ER_ID_Unk0EB
    wait $01

    ER_InitializeSIO
    wait $01

    ER_ConfigureSIO $02, $B9A0, $0076, $08
    ER_UpdateSIOLinkStatus
.wait_for_initialize
    wait $01
    ER_GetSIOConnectedStatus2
    cp $01
    jr z, .wait_for_initialize ; loop while status is 1

    ER_GetSIOConnectedStatus2
    or a
    jr z, .wait_for_initialize ; loop while status is 0
.wait_for_link
    wait $01
    GF_JumpIfNotPressed ER_KEY_B, .wait_for_link_1

    ; If user presses B while waiting,
    ; Reset SIO, set a = 0, return
    ER_API ER_ID_Unk0EB
    xor a
    ret
.wait_for_link_1
    ER_GetSIOConnectedStatus
    cp $02
    jr c, .wait_for_link

    ; end of function
    ; a = 1, return
    ld a,$01
    ret

WaitForGBALinkReady:
    wait $01
    ER_GetSIOConnectedStatus
    cp $02
    jr nc, .check_status_3_4

    ; Reset SIO, set a = 0, return
    ER_API ER_ID_Unk0EB
    xor a
    ret
.check_status_3_4:
    ER_GetSIOConnectedStatus2
    cp $04
    jr z, .link_ready ; if a = 4, goto link ready

    ER_GetSIOConnectedStatus2
    cp $03
    jr nz, WaitForGBALinkReady ; if a != 3 keep waiting
.link_ready:
    ld a,$01
    ret

VerifyConnectionPartner:
    wait $01
    ER_SIORead SIO_RX_Buff
    or a
    jr nz, .msg_received

    ; no message, a = 0, return
    ER_API ER_ID_Unk0EB
    xor a
    ret
.msg_received
    ; Ensure HL = $2222 or retry
    LD_HL_IND SIO_RX_Buff
    ld a,l
    cp $22
    jr nz, VerifyConnectionPartner
    ld a,h
    cp $22
    jr nz, VerifyConnectionPartner

    ; everything good. a = 1, return
    ld a,$01
    ret

SendDataPayload: ; a = payload idx to send
    ; stash the a parameter away
    LD_IND_A SendDataPayloadIdx

    ; Transfer the prologue
    ld de, 60 ; transfer size
    ld hl, Prologue
    call TransferData
    or a
    jr nz, .send_selected_payload

    ; Transfer failed, reset, a = 0, return
    ER_API ER_ID_Unk0EB
    xor a
    ret
.send_selected_payload
    ; hl = $0000 | (*SendDataPayloadIdx & 0xFF)
    ld hl,SendDataPayloadIdx
    ld l,[hl]
    ld h,$00
    ; hl = hl * 2
    add hl,hl
    ; de = DataPointers, which is an array to all the data payloads
    ld de,DataPointers
    ; hl = &DataPointers[SendDataPayloadIdx], a poiner to a specific data payload
    add hl,de
    ; load the first byte of the pointer to the tranfer data into e
    ld e,[hl]
    ; move one byte
    inc hl
    ; load the second byte of the pointer to the tranfer data into d
    ld d,[hl]
    ; hl = de, hl holds the pointer to the data to be transfered
    EX_DE_HL
    ; this number is just WAY over allocated
    ; sending $101 is fine, though $100 is too small
    ; strange since the payload is $7f
    ld de, $0800 ; transfer size
    call TransferData
    or a
    jp nz, SendFinalPacket

    ; Transfer failed, reset, a = 0, return
    ER_API ER_ID_Unk0EB
    xor a
    ret

    db $00 ; ??? maybe not needed? unless its alignment?

;Text Section
;Has Japanese text bytes if you want. Just uncomment tehm and comment the english text

TitleText:
    db "DECORATION PRESENT\0"
    ;db $82,$E0,$82,$E6,$82,$A4,$82,$AA,$82,$A6,$83,$4F,$83,$62,$83,$59,$81,$40,$83,$76,$83,$8C,$83,$5B,$83,$93,$83,$67,$00

FrontPageText: ; 1872
    db "“Decorate your SECRET BASE!”\0"
    ;db $81,$75,$82,$D0,$82,$DD,$82,$C2,$82,$AB,$82,$BF,$82,$F0,$82,$A9,$82,$B4,$82,$EB,$82,$A4,$81,$49,$81,$76,$83,$4C,$83,$83,$83,$93,$83,$79,$81,$5B,$83,$93,$82,$C9,$00
FrontPageTextLine2:
    db "Thank you for participating!\0"
    ;db $82,$B2,$82,$A8,$82,$A4,$82,$DA,$82,$A2,$82,$BD,$82,$BE,$82,$AB,$81,$40,$82,$A0,$82,$E8,$82,$AA,$82,$C6,$82,$A4,$82,$B2,$82,$B4,$82,$A2,$82,$DC,$82,$B5,$82,$BD,$00
FrontPageTextLine3:
    db "Please press the A Button.\0"
    ;db $82,$60,$83,$7B,$83,$5E,$83,$93,$82,$F0,$81,$40,$82,$A8,$82,$B5,$82,$C4,$82,$AD,$82,$BE,$82,$B3,$82,$A2,$00

FirstPage:
    db "Please press the A Button\0"
    ;db $82,$C2,$82,$AC,$82,$CC,$82,$C8,$82,$A9,$82,$A9,$82,$E7,$81,$40,$82,$A8,$82,$AD,$82,$E8,$82,$BD,$82,$A2,$81,$40,$82,$E0,$82,$E6,$82,$A4,$82,$AA,$82,$A6,$83,$4F,$83,$62,$83,$59,$82,$F0,$00
FirstPageLine2:
    db "to select a decoration\0"
    ;db $82,$A6,$82,$E7,$82,$F1,$82,$C5,$81,$40,$82,$60,$83,$7B,$83,$5E,$83,$93,$82,$F0,$81,$40,$82,$A8,$82,$B5,$82,$C4,$81,$40,$82,$AD,$82,$BE,$82,$B3,$82,$A2,$00
FirstPageLine3:
    db "from the list to send.\0"
    ;db $00


SecondPage:
    db "Link e-Reader to Pokémon Ruby or\0"
    ;db $82,$C2,$82,$A4,$82,$B5,$82,$F1,$83,$50,$81,$5B,$83,$75,$83,$8B,$82,$C5,$81,$40,$83,$4A,$81,$5B,$83,$68,$82,$85,$83,$8A,$81,$5B,$83,$5F,$81,$5B,$81,$7B,$82,$C6,$00
SecondPageLine2:
    db "Sapphire and select MYSTERY EVENTS\0"
    ;db $83,$7C,$83,$50,$83,$82,$83,$93,$81,$40,$83,$8B,$83,$72,$81,$5B,$81,$40,$82,$A9,$81,$40,$83,$54,$83,$74,$83,$40,$83,$43,$83,$41,$82,$F0,$81,$40,$82,$C2,$82,$C8,$82,$AC,$00
SecondPageLine3:
    db "on the game's main menu.\0"
    ;db $81,$75,$82,$D3,$82,$B5,$82,$AC,$82,$C8,$81,$40,$82,$C5,$82,$AB,$82,$B2,$82,$C6,$81,$76,$82,$F0,$81,$40,$82,$A6,$82,$E7,$82,$F1,$82,$C5,$81,$40,$82,$AD,$82,$BE,$82,$B3,$82,$A2,$00


ThirdPage:
    db "will be sent.\0"
    ;db $82,$F0,$81,$40,$82,$A8,$82,$AD,$82,$E8,$82,$DC,$82,$B7,$00
ThirdPageLine2:
    db "Please press the A Button on\0"
    ;db $83,$7C,$83,$50,$83,$82,$83,$93,$81,$40,$83,$8B,$83,$72,$81,$5B,$81,$40,$82,$A9,$81,$40,$83,$54,$83,$74,$83,$40,$83,$43,$83,$41,$82,$CC,$00
ThirdPageLine3:
    db "Pokémon Ruby or Sapphire.\0"
    ;db $82,$60,$83,$7B,$83,$5E,$83,$93,$82,$F0,$81,$40,$82,$A8,$82,$B5,$82,$C4,$81,$40,$82,$AD,$82,$BE,$82,$B3,$82,$A2,$00


FourthPage:
    db "is being sent.\0"
    ;db $82,$F0,$81,$40,$82,$A8,$82,$AD,$82,$C1,$82,$C4,$81,$40,$82,$A2,$82,$DC,$82,$B7,$00
FourthPageLine2:
    db "Don't remove the Game Link cable.\0"
    ;db $82,$C2,$82,$A4,$82,$B5,$82,$F1,$83,$50,$81,$5B,$83,$75,$83,$8B,$82,$F0,$81,$40,$82,$CA,$82,$A9,$82,$C8,$82,$A2,$82,$C5,$81,$40,$82,$AD,$82,$BE,$82,$B3,$82,$A2,$00
FourthPageLine3:
    db "Don't turn off the power.\0"
    ;db $82,$C5,$82,$F1,$82,$B0,$82,$F1,$82,$F0,$81,$40,$82,$AB,$82,$E7,$82,$C8,$82,$A2,$82,$C5,$81,$40,$82,$AD,$82,$BE,$82,$B3,$82,$A2,$00


FifthPage:
    db "has been received.\0"
    ;db $82,$AA,$81,$40,$82,$A8,$82,$AD,$82,$E7,$82,$EA,$81,$40,$82,$DC,$82,$B5,$82,$BD,$00
FifthPageLine2:
    db "Press the A Button to start over.\0"
    ;db $82,$60,$83,$7B,$83,$5E,$83,$93,$82,$C5,$81,$40,$82,$CD,$82,$B6,$82,$DF,$82,$A9,$82,$E7,$81,$40,$82,$E2,$82,$E8,$82,$C8,$82,$A8,$82,$B5,$82,$DC,$82,$B7,$00
FifthPageLine3:
    db "Press the B Button to exit.\0"
    ;db $82,$61,$83,$7B,$83,$5E,$83,$93,$82,$C5,$81,$40,$82,$B5,$82,$E3,$82,$A4,$82,$E8,$82,$E5,$82,$A4,$81,$40,$82,$B5,$82,$DC,$82,$B7,$00


TransferFailed:
    db "Link failed...\0"
    ;db $82,$C4,$82,$F1,$82,$BB,$82,$A4,$82,$C9,$81,$40,$82,$B5,$82,$C1,$82,$CF,$82,$A2,$82,$B5,$82,$DC,$82,$B5,$82,$BD,$00

PressA:
    db "Press the A Button to start over.\0"
    ;db $82,$60,$83,$7B,$83,$5E,$83,$93,$82,$C5,$81,$40,$82,$CD,$82,$B6,$82,$DF,$82,$A9,$82,$E7,$81,$40,$82,$E2,$82,$E8,$82,$C8,$82,$A8,$82,$B5,$82,$DC,$82,$B7,$00

FinishB:
    db "Press the B Button to exit.\0"
    ;db $82,$61,$83,$7B,$83,$5E,$83,$93,$82,$C5,$81,$40,$82,$B5,$82,$E3,$82,$A4,$82,$E8,$82,$E5,$82,$A4,$82,$B5,$82,$DC,$82,$B7,$00

TransferCancelled:
    db "The link was canceled.\0"
    ;db $82,$C4,$82,$F1,$82,$BB,$82,$A4,$82,$F0,$81,$40,$83,$4C,$83,$83,$83,$93,$83,$5A,$83,$8B,$82,$B5,$82,$DC,$82,$B5,$82,$BD,$00

;idk why there's two of these
PressA2:
    db "Press the A Button to start over.\0"
    ;db $82,$60,$83,$7B,$83,$5E,$83,$93,$82,$C5,$81,$40,$82,$CD,$82,$B6,$82,$DF,$82,$A9,$82,$E7,$81,$40,$82,$E2,$82,$E8,$82,$C8,$82,$A8,$82,$B5,$82,$DC,$82,$B7,$00

FinishB2:
    db "Press the B Button to exit.\0"
    ;db $82,$61,$83,$7B,$83,$5E,$83,$93,$82,$C5,$81,$40,$82,$B5,$82,$E3,$82,$A4,$82,$E8,$82,$E5,$82,$A4,$82,$B5,$82,$DC,$82,$B7,$00

;The items in order that they'll appear
;Second and third options may need spaces at the start
;My guess as to why is in Japanese the regi dolls have the same length and so moves ahead a certain amount instead of using pointers
RegirockDollText:
    db "REGIROCK DOLL \0"
    ;db $83,$8C,$83,$57,$83,$8D,$83,$62,$83,$4E,$83,$68,$81,$5B,$83,$8B,$00

RegiceDollText:
    db "  REGICE DOLL \0"
    ;db $83,$8C,$83,$57,$83,$41,$83,$43,$83,$58,$83,$68,$81,$5B,$83,$8B,$00

RegisteelDollText:
    db "    REGISTEEL DOLL \0"
    ;db $83,$8C,$83,$57,$83,$58,$83,$60,$83,$8B,$83,$68,$81,$5B,$83,$8B,$00



;Graphics Section

ArrowSprite:
    INCBIN "build/gfx/decoration/arrow.4bpp"
ArrowPalette:
    INCBIN "build/gfx/decoration/arrow.gbapal"

;Sprites are in order of 1-3-2
RegirockSprite:
    INCBIN "build/gfx/decoration/regirock.4bpp"
RegisteelSprite:
    INCBIN "build/gfx/decoration/registeel.4bpp"
RegiceSprite:
    INCBIN "build/gfx/decoration/regice.4bpp"

;All 3 regi dolls share the same palette
RegiPalette:
    INCBIN "build/gfx/decoration/registeel.gbapal"

TextboxesTiles:
    INCBIN "build/gfx/decoration/textboxes.4bpp"
TextboxesPalette:
    INCBIN "build/gfx/decoration/textboxes.gbapal"
TextboxesTilemap:
    INCBIN "gfx/decoration/textboxes.tilemap"

PokeballBgTiles:
    INCBIN "build/gfx/decoration/pokeball_bg.4bpp"
PokeballBgPalette:
    INCBIN "build/gfx/decoration/pokeball_bg.gbapal"
PokeballBgTilemap:
    INCBIN "gfx/decoration/pokeball_bg.tilemap"

;This tilemap is just for the first large textbox
TextboxMainTilemap:
    INCBIN "gfx/decoration/textbox_main.tilemap"


;Pointers to graphics
dstruct ER_CustomSprite, \
  ArrowSpriteData, \
    .TilePtr=ArrowSprite, \
    .PalettePtr=ArrowPalette, \
    .Width=1, \
    .Height=1, \
    .FramesPerBank=1, \
    .Unknown=1, \
    .HitBoxWidth=0, \
    .HitBoxHeight=0, \
    .FrameCount=1

dstruct ER_CustomSprite, \
  RegirockSpriteData, \
    .TilePtr=RegirockSprite, \
    .PalettePtr=RegiPalette, \
    .Width=4, \
    .Height=4, \
    .FramesPerBank=3, \
    .Unknown=1, \
    .HitBoxWidth=0, \
    .HitBoxHeight=0, \
    .FrameCount=3

dstruct ER_CustomBackground, \
  TextboxesData, \
    .TilePtr=TextboxesTiles, \
    .PalettePtr=TextboxesPalette, \
    .MapPtr=TextboxesTilemap, \
    .TileCount=10, \
    .PaletteCount=1

dstruct ER_CustomBackground, \
  PokeballBgData, \
    .TilePtr=PokeballBgTiles, \
    .PalettePtr=PokeballBgPalette, \
    .MapPtr=PokeballBgTilemap, \
    .TileCount=10, \
    .PaletteCount=1

dstruct ER_CustomBackground, \
  TextboxMainData, \
    .TilePtr=TextboxesTiles, \
    .PalettePtr=TextboxesPalette, \
    .MapPtr=TextboxMainTilemap, \
    .TileCount=10, \
    .PaletteCount=1

; Not exactly sure what this is but I think it's setting up layer stuff
; This specific label isn't directly referenced anywhere but could be referenced
; directly via rom or indirect pointer. More research needed
BGSetUpStuffIThink:
    db $03,$03,$66,$15

Window1:
    db $00, ; x1
    db $18, ; y1
    db $F0, ; x2
    db $88, ; y2
    dw $2129 ; winin
    dw $3727 ; winout
Window2:
    db $00, ; x1
    db $18, ; y1
    db $F0, ; x2
    db $88, ; y2
    dw $2129 ; winin
    dw $3727 ; winout
Window3:
    db $00, ; x1
    db $00, ; y1
    db $F0, ; x2
    db $23, ; y2
    dw $202F ; winin
    dw $003F ; winout

DollLoadAnimationComplete:
    db $00
TextPalette:
    INCBIN "gfx/decoration/text.gbapal"



;Starting function, sets everything up
Start::
    ; Top of the stack is where the arrow points
    ; load up zero to select the first option by defaul
    ld e, 0
    push de

    ; Background setup
    ER_SetBackgroundMode 0
    ER_SetBackgroundPriority 3, 2, 1, 0
    ER_LoadCustomBackground TextboxesData, 1
    ER_LoadCustomBackground PokeballBgData, 0
    ER_SetBackgroundAutoScroll 0, $ff80, $0080
    ER_LoadCustomBackground TextboxMainData, 3
    SetBackgroundPalette 6, $00f0, TextPalette
    CreateRegion TitleRegionHandlePtr, 26, 3, 2, 0, 2, 15
    CreateRegion OptionsRegionHandlePtr, 13, 7, 3, 5, 2, 15
    CreateRegion InstructRegionHandlePtr, 30, 6, 0, 14, 2, 15

    DG_SetTextSize TitleRegionHandlePtr, ER_SetTextSize_Large
    DG_SetTextSize OptionsRegionHandlePtr, ER_SetTextSize_Large
    DG_SetTextSize InstructRegionHandlePtr, ER_SetTextSize_Medium

    SetTextColor TitleRegionHandlePtr, 1, 0
    SetTextColor OptionsRegionHandlePtr, 1, 0
    SetTextColor InstructRegionHandlePtr, 1, 0
    SetRegionColor InstructRegionHandlePtr, 0   ;This isn't in the original, the japanese ereader sets the text background to be transparent automatically

    call WriteText
    call RegiSelectText

    DG_UpdateText FirstPage, FirstPageLine2, FirstPageLine3

    ER_SpriteCreate ArrowSpriteHandlePtr, $80, ArrowSpriteData
    ER_SpriteCreate RegirockSpriteHandlePtr, $02, RegirockSpriteData
    ER_SetSpritePos RegirockSpriteHandlePtr, $00b8, $0044
    SpriteAutoScaleUntilSize RegirockSpriteHandlePtr, $01, $0100
    ER_SpriteShow RegirockSpriteHandlePtr

    ; --- de, bc, hl
    ld c, $06
    ld e, $14
    ld hl, $00f0
    ER_API ER_ID_Unk81A            ; Unknown API call
    ; ---

    ER_PlayStaticSystemSound $0081

    ; make a copy of the
    ; selected arrow then load into a
    pop de
    push de
    ld a,e
    call UpdateArrowSpritePos
    call AnimateArrowSprite

    SpriteAutoScaleUntilSize RegirockSpriteHandlePtr, $01, $0f00

    call RenderWelcomePage

    ; Reveal the original content?
    ld de, Window3
    ld a, $20
    ER_API ER_ID_WindowShow

    call AnimateDollIn

    ; put the arrow position in de
    pop de

MainLoop:
.check_if_key_dup
    GF_JumpIfNotPressed ER_KEY_DUP, .check_if_key_ddown
    ; Up was pressed. decrease the index with wrapping
    inc e
    dec e
    jr nz, .up_no_wrap
    ld e, $02 ; if wrap directly set to bottom index $02
    jr .up_with_wrap
.up_no_wrap
    dec e
.up_with_wrap
    push de ; save the location on the stack
    ER_PlayStaticSystemSound $0000
    pop de
    push de
    ld a, e
    call UpdateArrowSpritePos
    LD_HL_IND RegirockSpriteHandlePtr
    ER_API ER_ID_SetSpriteFrameNext
    pop de
.check_if_key_ddown
    GF_JumpIfNotPressed ER_KEY_DDOWN, .check_if_key_a
    ; Down was pressed. increase the index with wrapping
    ld a,e
    cp $02
    jr nz, .down_no_wrap
    ld e,$00 ; if wrap directly set to top index $00
    jr .down_with_wrap
.down_no_wrap
    inc e
.down_with_wrap
    push de ; save the location on the stack
    ER_PlayStaticSystemSound $0000
    pop de
    push de
    ld a,e
    ; Redraw in case the index was updated
    call UpdateArrowSpritePos

    ; this is interesting. Are the sprite "frames" the 3 different images for each selection
    ; this is the correct place to be updating the rendered sprite. Quite a cheey solution
    ; to that problem.
    LD_HL_IND RegirockSpriteHandlePtr
    ER_API ER_ID_SetSpriteFramePrevious

    pop de ; keep up the stack dance
.check_if_key_a
    GF_JumpIfNotPressed ER_KEY_A, .store_wait_loop
    ; A was pressed, time to kick off all the fun
    push de
    call ClearArrowSpriteAnimation
    ER_PlayStaticSystemSound $0005
    pop de
    push de
    ld a,e
    call TransferSelection
    wait $01
    pop de
.transfer_canceled_check_a
    GF_JumpIfNotPressed ER_KEY_A, .transfer_canceled_check_b
    ; A was pressed, redraw starting UI
    push de
    ER_PlayStaticSystemSound $0005
    call AnimateArrowSprite
    LD_A_IND DollLoadAnimationComplete
    or a
    call z, AnimateDollIn
    DG_UpdateText FirstPage, FirstPageLine2, FirstPageLine3
    ER_PlayStaticSystemSound $0081
    pop de
    jr .store_wait_loop
.transfer_canceled_check_b
    push de
    GF_JumpIfNotPressed ER_KEY_B, .transfer_canceled_wait
    ; B was pressed, exit application
    ER_Exit ER_Exit_Menu
.transfer_canceled_wait
    wait $01
    pop de
    jr .transfer_canceled_check_a
.store_wait_loop
    push de
    wait $01
    pop de
    jp MainLoop

; a = index of arrow
UpdateArrowSpritePos:
    ; convert index into pointer offset
    ld l,a
    ld h,$00
    add hl,hl

    ; de = hl
    ld e,l
    ld d,h
    ; hl = hl * 9
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,de
    ; hl = hl + $31
    ld de,$0031
    add hl,de

    ; y pixel location
    ld c,l
    ld b,h
    ; x pixel location
    ld de,$0012
    LD_HL_IND ArrowSpriteHandlePtr
    ER_API ER_ID_SetSpritePos
    ret

AnimateArrowSprite:
    ld l,$41
    push hl
    ld bc,$0002
    ld de,$0600
    LD_HL_IND ArrowSpriteHandlePtr
    ; Auto animates the sprite left and right
    ; sp, hl, de, bc
    ER_API ER_ID_Unk059
    pop bc
    ret

ClearArrowSpriteAnimation:
    ld l,$41
    push hl
    ld bc,$0000
    ld de,$0000
    LD_HL_IND ArrowSpriteHandlePtr
    ER_API ER_ID_Unk059
    pop bc
    ret

TransferSelection: ; a = selected idx
    LD_IND_A TransferDataSelection
    ER_FadeOutSong $0081, $0040
    SuppressPauseScreen
    DG_UpdateText SecondPage, SecondPageLine2, SecondPageLine3
    call WaitForGBALink
    or a
    jr nz, .past_link
    wait $01
    ER_PlayStaticSystemSound $0004
    DG_UpdateText TransferCancelled, PressA2, FinishB2
    UnsuppressPauseScreen
    xor a
    ret

.past_link
    COPY_SELECTION_STR_INTO_BUF
    ld de,ThirdPage
    ld hl,SelectedRegiTextPtr
    call StringCat ; copy ThirdPage into SelectedRegiTextPtr after the name
    DG_UpdateText SelectedRegiTextPtr, ThirdPageLine2, ThirdPageLine3
    call WaitForGBALinkReady
    or a
    jr nz, .past_ready
    wait $01
    ER_PlayStaticSystemSound $0004
    DG_UpdateText TransferFailed, PressA, FinishB
    UnsuppressPauseScreen
    xor a
    ret

.past_ready
    call VerifyConnectionPartner
    or a
    jr nz, .past_verify_partner
    wait $01
    ER_PlayStaticSystemSound $0004
    DG_UpdateText TransferFailed, PressA, FinishB
    UnsuppressPauseScreen
    xor a
    ret

.past_verify_partner
    call AnimateDollOut
    COPY_SELECTION_STR_INTO_BUF
    ld de,FourthPage ; $05ad
    ld hl,SelectedRegiTextPtr
    call StringCat
    DG_UpdateText SelectedRegiTextPtr, FourthPageLine2, FourthPageLine3
    wait $01
    LD_A_IND TransferDataSelection
    call SendDataPayload
    or a
    jr nz, .past_send_payload
    wait $01
    ER_PlayStaticSystemSound $0004
    DG_UpdateText TransferFailed, PressA, FinishB
    UnsuppressPauseScreen
    xor a
    ret

.past_send_payload
    COPY_SELECTION_STR_INTO_BUF
    ld de,FifthPage
    ld hl,SelectedRegiTextPtr
    call StringCat
    DG_UpdateText SelectedRegiTextPtr, FifthPageLine2, FifthPageLine3
    UnsuppressPauseScreen
    ER_PlayStaticSystemSound $00FA
    ld a, $01 ; a = 1 tell caller everything went okay
    ret

RenderWelcomePage:
    ld de, Window1
    ld a,$20
    ER_API ER_ID_WindowShow

    ld de, Window2
    ld a, $40
    ER_API ER_ID_WindowShow

    ld a,$03
    ER_API ER_ID_LayerShow

    ld bc,$1a07
    ld de,$0205
    ld hl,$030f
    ER_API ER_ID_CreateRegion

    ld c,a
    push bc
    ld a,c
    ld e,$02
    ER_API ER_ID_SetRegionColor
    pop bc

    push bc
    ld a,c
    ER_API ER_ID_ClearRegion
    pop bc

    push bc
    ld hl,$0001
    ld a,c
    or h
    ld h,a
    ER_API ER_ID_SetTextSize
    pop bc

    push bc
    ld a,c
    ld de,$0102
    ER_API ER_ID_SetTextColor
    pop bc

    push bc
    ld a,c
    ld de,FrontPageText
    ER_API ER_ID_GetTextWidth
    ld l,a
    ld a,$d0
    sub l
    ld b,$02
    call unclear_math
    LD_IND_A UnclearMathResult
    pop bc

    push bc
    LD_A_IND UnclearMathResult
    ld de,$000a
    or d
    ld d,a
    ld a,c
    ld bc,FrontPageText
    ER_API ER_ID_DrawText
    pop bc

    push bc
    ld a,c
    ld de,FrontPageTextLine2
    ER_API ER_ID_GetTextWidth
    ld l,a
    ld a,$d0
    sub l
    ld b,$02
    call unclear_math
    LD_IND_A UnclearMathResult
    pop bc

    push bc
    LD_A_IND UnclearMathResult
    ld de,$0014
    or d
    ld d,a
    ld a,c
    ld bc,FrontPageTextLine2
    ER_API ER_ID_DrawText
    pop bc

    push bc
    ld a,c
    ld de,FrontPageTextLine3
    ER_API ER_ID_GetTextWidth
    ld l,a
    ld a,$d0
    sub l
    ld b,$02
    call unclear_math
    LD_IND_A UnclearMathResult
    pop bc

    LD_A_IND UnclearMathResult
    ld de,$0028
    or d
    ld d,a
    ld a,c
    ld bc,FrontPageTextLine3
    ER_API ER_ID_DrawText

    ER_FadeIn $20

.loop_until_a
    GF_JumpIfPressed ER_KEY_A, .clear_welcome_screen
    wait $01
    jr .loop_until_a

.clear_welcome_screen:
    ER_PlayStaticSystemSound $0005
    ld a,$03
    ER_API ER_ID_LayerHide
    ld a,$20
    ER_API ER_ID_WindowHide
    ld a,$40
    ER_API ER_ID_WindowHide
    wait $01
    ret

AnimateDollOut:
    ER_PlayStaticSystemSound $0014
    ld c,$30
    ld de,$0180
    LD_HL_IND RegirockSpriteHandlePtr
    ER_API ER_ID_SpriteAutoScaleUntilSize
    wait $60
    ER_PlayStaticSystemSound $0068
    ER_SetSpritePosAnimatedDuration RegirockSpriteHandlePtr, $00b8, $ffe0, $20
    wait $10
    xor a
    LD_IND_A DollLoadAnimationComplete
    ret


AnimateDollIn:
    ld c,$01
    ld de,$0f00
    LD_HL_IND RegirockSpriteHandlePtr
    ER_API ER_ID_SpriteAutoScaleUntilSize

    ld bc,$0044
    ld de,$00b8
    LD_HL_IND RegirockSpriteHandlePtr
    ER_API ER_ID_SetSpritePos

    ld c,$40
    ld de,$0100
    LD_HL_IND RegirockSpriteHandlePtr
    ER_API ER_ID_SpriteAutoScaleUntilSize

    wait $20
    ER_PlayStaticSystemSound $0068
    wait $40

    ld a,$01
    LD_IND_A DollLoadAnimationComplete
    ret


WriteText:
    CLEAR_REGION TitleRegionHandlePtr
    GetTextWidth TitleRegionHandlePtr, TitleText
    ld l,a
    ld a,$d0
    sub l
    ld b,$02
    call unclear_math
    LD_IND_A UnclearMathResult
    ld a, $06
    LD_IND_A WriteTextStash
    ld bc, TitleText
    LD_A_IND WriteTextStash
    ld e, a
    LD_A_IND UnclearMathResult
    ld d, a
    LD_A_IND TitleRegionHandlePtr
    ER_API ER_ID_DrawText
    ret

RegiSelectText:
    DrawText OptionsRegionHandlePtr, RegirockText2, 0, 4
    ld bc, RegiceText2
    ld de, $0016
    LD_A_IND OptionsRegionHandlePtr
    ER_API ER_ID_DrawText
    ld bc, RegisteelText2
    ld de, $0028
    LD_A_IND OptionsRegionHandlePtr
    ER_API ER_ID_DrawText
    ret


;This is the text you see on the menu select textbox, in order they appear

RegirockText2:
    db "REGIROCK DOLL\0"
    ;db $83,$8C,$83,$57,$83,$8D,$83,$62,$83,$4E,$83,$68,$81,$5B,$83,$8B,$00

RegiceText2:
    db "REGICE DOLL\0"
    ;db $83,$8C,$83,$57,$83,$41,$83,$43,$83,$58,$83,$68,$81,$5B,$83,$8B,$00

RegisteelText2:
    db "REGISTEEL DOLL\0"
    ;db $83,$8C,$83,$57,$83,$58,$83,$60,$83,$8B,$83,$68,$81,$5B,$83,$8B,$00


UpdateText: ; hl = Line1, de = Line2, bc = Line2
    push bc
    push de
    push hl
    CLEAR_REGION InstructRegionHandlePtr
    pop hl
    push hl
    EX_DE_HL
    LD_A_IND InstructRegionHandlePtr
    ER_API ER_ID_GetTextWidth
    ld l, a
    ld a, $f0
    sub l
    ld b, $02
    call unclear_math
    LD_IND_A UnclearMathResult
    pop bc
    LD_A_IND UnclearMathResult
    ld de, $000A
    or d
    ld d, a
    LD_A_IND InstructRegionHandlePtr
    ER_API ER_ID_DrawText
    pop de
    push de
    LD_A_IND InstructRegionHandlePtr
    ER_API ER_ID_GetTextWidth
    ld l, a
    ld a, $f0
    sub l
    ld b, $2
    call unclear_math
    LD_IND_A UnclearMathResult
    pop bc
    LD_A_IND UnclearMathResult
    ld de, $0014
    or d
    ld d, a
    LD_A_IND InstructRegionHandlePtr
    ER_API ER_ID_DrawText
    pop bc
    push bc
    ld e, c
    ld d, b
    LD_A_IND InstructRegionHandlePtr
    ER_API ER_ID_GetTextWidth
    ld l, a
    ld a, $f0
    sub l
    ld b, $2
    call unclear_math
    LD_IND_A UnclearMathResult
    pop bc
    LD_A_IND UnclearMathResult
    ld de, $001E
    or d
    ld d, a
    LD_A_IND InstructRegionHandlePtr
    ER_API ER_ID_DrawText
    ret

; Concats the string at de into hl
; hl must be filled will null bytes
; in the buffer being copied into
StringCat:
    ld a, [hl]
    or a
    jr z, .null_found ; if *hl = 0, go to null
    inc hl ; else increment the address and loop
    jr StringCat
.null_found
    LD_IND_A_DE ; ld a, [de]
    inc de ; increment de pointer
    LD_IND_HL_A ; ld [hl], a
    inc hl ; increment hl pointer
    or a
    jr nz, .null_found ; if *hl = 0, go to null
    xor a ; a = 0
    LD_IND_HL_A ; ld [hl], a
    inc hl ; increment the ptr
    ret

WordShiftRight:
    ; this function shifts HL by B bits to the right
    inc b ; b++
.wsr_loop
    dec b ; b--
    ret z ; return if b is 0

    and a ; clear the carry flag so rra doesn't copy it over
    ld a, h ; a = h
    rra ; a >> 1
    ld h, a ; h = a
    ld a, l ; a = l
    rra ; a >> 1
    ld l, a ; l = a
    jp .wsr_loop ; loop

; I think *maybe* this is fast restricted version of a / b?
unclear_math: ; a = ??, b = ??
    push hl
    ld l,a
    ld h,$00 ; hl = $00XX
    ld c,$08 ; c = $08
label_282A:
    add hl,hl ; hl = hl * 2
    ld a,h ; a = h
    cp b
    jp c,label_2833 ;  if a < b jump
    sub b
    inc l
    ld h,a
label_2833:
    dec c ; c--
    jp nz,label_282A ; if c > 0 jump
    ld a,l
    ld b,h
    pop hl
    ret

WordTransferCount:: dw
NextByteToTX:: dw
SendDataPayloadIdx:: db
TransferDataSelection:: db
InstructRegionHandlePtr:: db
ArrowSpriteHandlePtr: dw
OptionsRegionHandlePtr:: db
RegirockSpriteHandlePtr:: dw
TitleRegionHandlePtr:: db
UnclearMathResult:: db
WriteTextStash:: db
SelectedRegiTextPtr:: db

; Stripping metadata. How many bytes above this
; byte should be stripped.
EOF_OFFSET $10
