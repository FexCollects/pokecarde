INCLUDE "include/z80.asm"

INCLUDE "include/structs.inc"
rgbds_structs_version 4.1.0
def STRUCT_SEPARATOR equs "."

; ER_API:
;   Calls into the ereader api. If the api number is less than $100 uses rst 0
;   otherwise uses rst 8. By convention $8XX is used for the rst 8 apis but its
;   not required. Doing this instead of having an API_0 and API_8 simplifies the
;   call stack at the cost of slightly renaming api numbers from publicly
;   available documentation
MACRO ER_API
    IF \1 < $100
        rst 0
    ELSE
        rst 8
    ENDC

    ; remove the upper bit which was only used to pick the rst
    db (\1 & $FF)
ENDM

; KEY_INPUT:
;   Handles checking for key presses from the user. Both registers return a
;   word containing a bitfield of the keys pressed. NEW returns true for keys
;   just pressed this frame, while CUR returns all keys currently pressed
DEF ER_KEY_INPUT_NEW EQU $C2
DEF ER_KEY_INPUT_CUR EQU $C4
DEF ER_KEY_A      EQU 0b00000001
DEF ER_KEY_B      EQU 0b00000010
DEF ER_KEY_SELECT EQU 0b00000100
DEF ER_KEY_START  EQU 0b00001000
DEF ER_KEY_DRIGHT EQU 0b00010000
DEF ER_KEY_DLEFT  EQU 0b00100000
DEF ER_KEY_DUP    EQU 0b01000000
DEF ER_KEY_DDOWN  EQU 0b10000000
; These are in the high byte
DEF ER_KEY_TR     EQU 0b00000001
DEF ER_KEY_TL     EQU 0b00000010

; The IDs for each ereader api function
DEF ER_ID_FadeIn EQU $000
DEF ER_ID_FadeOut EQU $001
; 0x02 	ERAPI_FlashWhite
; 0x04 (?) blend_func_unk1
; 0x09 (?) _020264CC_check
; 0x0A (?) _020264CC_free
; $00B-$00F Don't have defined functions
DEF ER_ID_LoadSystemBackground EQU $010
DEF ER_ID_SetBackgroundOffset EQU $011
DEF ER_ID_SetBackgroundAutoScroll EQU $012
DEF ER_ID_BackgroundMirrorToggle EQU $013
; 0x16 (?) write_000000FF_to_02029494_
DEF ER_ID_SetBackgroundMode EQU $019
DEF ER_ID_Unk01a EQU $01a
DEF ER_ID_LayerShow EQU $020
DEF ER_ID_LayerHide EQU $021
DEF ER_ID_FillBackgroundTile EQU $02C
DEF ER_ID_LoadCustomBackground EQU $02D
DEF ER_ID_CreateSystemSprite EQU $030
DEF ER_ID_SpriteFree EQU $031
DEF ER_ID_SetSpritePos EQU $032
; 0x33 (?) sprite_unk2
DEF ER_ID_SetSpriteFrameNext EQU $034
DEF ER_ID_SetSpriteFramePrevious EQU $035
DEF ER_ID_SetSpriteFrame EQU $036
DEF ER_ID_SetSpriteFrameBank EQU $037
; 0x38 (?) sprite_unk4
; 0x39 ERAPI_SetSpriteAutoMove
; 0x3A (?) sprite_unk5
DEF ER_ID_SetSpritePosAnimatedDuration EQU $03B
DEF ER_ID_SpriteAutoAnimate EQU $03C
; 0x3D (?) sprite_unk7
DEF ER_ID_SpriteAutoRotateUntilAngle EQU $03E
; 0x3F ERAPI_SpriteAutoRotateByAngle
DEF ER_ID_SpriteAutoRotateByTime EQU $040
; 0x41 (?) sprite_unk8
; 0x42 ERAPI_SetSpriteAutoMoveHorizontal
; 0x43 ERAPI_SetSpriteAutoMoveVertical
; 0x44 (?) sprite_unk9
DEF ER_ID_SpriteDrawOnBackground EQU $045
DEF ER_ID_SpriteShow EQU $046
DEF ER_ID_SpriteHide EQU $047
DEF ER_ID_SpriteMirrorToggle EQU $048
; 0x49 (?) sprite_unk10
; 0x4A (?) sprite_unk11
; 0x4B (?) sprite_unk12
DEF ER_ID_GetSpritePos EQU $04C
DEF ER_ID_SpriteCreate EQU $04D
; 0x4F (?) sprite_unk14
; 0x50 (?) sprite_unk15
; 0x51 (?) sprite_unk16
; 0x52 (?) sprite_unk17
; 0x53 (?) sprite_unk18
; 0x55 (?) sprite_unk20
DEF ER_ID_SpriteMove EQU $057
DEF ER_ID_SetSpriteHitboxSize EQU $058
DEF ER_ID_Unk059 EQU $059 ; sprite related
; 0x5A (?) sprite_unk24
DEF ER_ID_SpriteAutoScaleUntilSize EQU $05B
; 0x5C ERAPI_SpriteAutoScaleBySize
DEF ER_ID_SpriteAutoScaleWidthUntilSize EQU $05D
DEF ER_ID_SpriteAutoScaleHeightUntilSize EQU $05E ; ERAPI_SpriteAutoScaleHeightBySize?
; 0x65 (?) sprite_unk25
; 0x66 ERAPI_SetSpriteVisible ; Not documented by Matt, but it is documented
; HL 	sprite handle
; E 	0 = not visible / 1 = visible
; no return
; 0x67 (?) sprite_unk26
DEF ER_ID_SetSpriteType EQU $068
DEF ER_ID_GetSpriteType EQU $069
DEF ER_ID_DrawNumber EQU $06B
DEF ER_ID_DrawNumberNewValue EQU $06C
DEF ER_ID_DrawNumberDeltaValue EQU $06D
DEF ER_ID_DrawNumberGetValue EQU $06E
DEF ER_ID_DrawTime EQU $06F
DEF ER_ID_DrawTimeNewValue EQU $070
DEF ER_ID_DrawTimeDeltaValue EQU $071
DEF ER_ID_DrawNumberBlink EQU $072
; 0x7C (?) _0202FD2C_unk12
DEF ER_ID_SetBackgroundPalette EQU $07E
DEF ER_ID_GetBackgroundPalette EQU $07F
DEF ER_ID_SetSpritePalette EQU $080
DEF ER_ID_GetSpritePalette EQU $081
; 0x82 ERAPI_ClearPalette sprite?
; 0x83 (?) _0202FD2C_unk11
DEF ER_ID_Unk084 EQU $084
; 0x87 (?) _0202FD2C_unk8
; 0x88 (?) _0202FD2C_unk7
; 0x8A (?) _0202FD2C_unk6
; 0x8B (?) _0202FD2C_unk5
DEF ER_ID_PlayStaticSystemSound EQU $08D
DEF ER_ID_Unk08E EQU $08E
DEF ER_ID_WindowHide EQU $08F ; Not documented by Matt. a = $20 else anything
DEF ER_ID_CreateRegion EQU $090
DEF ER_ID_SetRegionColor EQU $091
DEF ER_ID_ClearRegion EQU $092
DEF ER_ID_SetPixel EQU $093
DEF ER_ID_GetPixel EQU $094
DEF ER_ID_DrawLine EQU $095
DEF ER_ID_DrawRect EQU $096
; 0x97 (?) _0202FD2C_unk4
DEF ER_ID_SetTextColor EQU $098
DEF ER_ID_DrawText EQU $099
DEF ER_ID_SetTextSize EQU $09A
DEF ER_ID_SetTextSpacing EQU $09B
; 0x9C (?) _0202FD2C_unk3
; 0x9D (?) _0202FD2C_unk2
; 0x9E (?) _0202FD2C_unk1
; 0xA2 (?) RegionUnk6
DEF ER_ID_FindClosestSprite EQU $0AA
DEF ER_ID_CalcDistanceBetweenSprites EQU $0AB
DEF ER_ID_CalcAngleBetweenTwoSprites EQU $0AC
; 0xAD (?) RegionUnk5
DEF ER_ID_Unk0AE EQU $0AE
DEF ER_ID_GetTextWidth EQU $0C0
; 0xC1 (?) RegionUnk1
DEF ER_ID_ScanDotCode EQU $0C2
DEF ER_ID_Unk0C4 EQU $0C4
DEF ER_ID_Unk0C5 EQU $0C5
DEF ER_ID_Unk0C6 EQU $0C6
DEF ER_ID_Unk0C7 EQU $0C7
DEF ER_ID_Unk0C8 EQU $0C8
DEF ER_ID_Unk0CA EQU $0CA
DEF ER_ID_SetSpritePosAnimatedSpeed EQU $0DA
DEF ER_ID_Unk0DB EQU $0DB
DEF ER_ID_Unk0DC EQU $0DC ; [0300465] = 1
DEF ER_ID_DecompressVPKOrNonVPK EQU $0DD
; 0xE0 ERAPI_SoftReset
DEF ER_ID_SpriteFindCollisions EQU $0E5
DEF ER_ID_GetSpritePaletteIndex EQU $0E6
DEF ER_ID_SetSpritePaletteIndex EQU $0E7
; 0xEA (?) BL_irq_sio_dma3
DEF ER_ID_Unk0EB EQU $0EB
; 0xEF (?) ERAPI_unk2
DEF ER_ID_SystemSpriteIdIsValid EQU $0F0
DEF ER_ID_RandomSeed EQU $0F1
DEF ER_ID_Exit EQU $800
DEF ER_ID_Mul8 EQU $801
DEF ER_ID_Mul16 EQU $802
DEF ER_ID_Div EQU $803
DEF ER_ID_Mod EQU $804
DEF ER_ID_PlaySystemSound EQU $805
DEF ER_ID_StopSong EQU $806
DEF ER_ID_Rand EQU $807
; 0x08 ERAPI_SetSoundVolume
; 0x0B ERAPI_Set_040000xx
; 0x0C ERAPI_Get_040000xx
; 0x11 ERAPI_Div_Signed
DEF ER_ID_RandMax EQU $812
DEF ER_ID_SetSoundSpeed EQU $813
DEF ER_ID_PauseSound EQU $816
DEF ER_ID_ResumeSound EQU $817
DEF ER_ID_PlaySystemSoundAtVolume EQU $818
DEF ER_ID_IsSoundPlaying EQU $819
DEF ER_ID_Unk81A EQU $81A
DEF ER_ID_FlashLoadUserData EQU $81B
DEF ER_ID_FlashSaveUserData EQU $81C
DEF ER_ID_SupressPauseScreen EQU $821
; 0x22 (?) ERAPI_sound_unk7
; 0x23 (?) ERAPI_sound_unk8
; 0x24 (?) ERAPI_sound_unk9
; 0x25 (?) ERAPI_sound_unk10
; 0x26 (?) bg0_bg1_bg2_bg3_mosaic
; 0x2A (?) get_u16_from_02030110
; 0x2C (?) get_u16_from_02030112
; 0x2D (?) get_u16_from_02030114
; 0x32 (?) Init_BLDCNT_FF_BLDY_08
; 0x33 (?) Init_BLDCNT_00
DEF ER_ID_ClearSpritesAndBackgrounds EQU $835
; 0x36 (?) ResetTimer3
; 0x37 (?) GetTimer3Counter

; Load \1 into a saving a byte when possible
MACRO LD_A_OPT
    IF \1 == 0
        xor a ; save a byte
    ELSE
        ld a, \1
    ENDC
ENDM

; ER_FadeIn:
;   Fades in the screen from black. Must be called in order for the screen to show
;   anything, so commonly used at least once at the beginning of an app booting up.
;
;   a: number of frames to fade in
MACRO ER_FadeIn
    ld a, \1
    ER_API ER_ID_FadeIn
ENDM

; ER_FadeOut:
;   Fades the screen to black.
;
;   a: number of frames to fade out
MACRO ER_FadeOut
    ld a, \1
    ER_API ER_ID_FadeOut
ENDM

; ER_LoadSystemBackground:
;   Loads one of the many system backgrounds present in the E-Reader's ROM.
;
;   a: System background ID (1-101)
;   e: background index (0-3)
MACRO ER_LoadSystemBackground
    ld a, \1
    ld e, \2
    ER_API ER_ID_LoadSystemBackground
ENDM

; ER_SetBackgroundAutoScroll:
;   Causes a background to continuously scroll. Ideally used on a background
;   which has wrapping graphics, many of the system backgrounds do
;   (such as #2, the starry night sky).
;
;   a: background index
;   de: x velocity
;   bc: y velocity
MACRO ER_SetBackgroundAutoScroll
    ld bc, \2
    ld de, \3
    LD_A_OPT \1
    ER_API ER_ID_SetBackgroundAutoScroll
ENDM

; ER_SetBackgroundMode:
;   Chooses one of the 3 background modes available on the GBA
;   0: Four standard, 2d backgrounds (most common)
;   1: Two standard, 2d backgrounds, 1 affine background
;   2: Two affine backgrounds
;   There is no known way to work with affine backgrounds with z80 ERAPI.
;
;   a: background mode: 0, 1 or 2 (see above)
MACRO ER_SetBackgroundMode
    LD_A_OPT \1
    ER_API ER_ID_SetBackgroundMode
ENDM

; ER_FillBackgroundTile:
;   Fills a portion of the screen with a tile in a specified background
;   layer. The api call doesn't pop the stack so you have to manually
;   pop it.x
;
;   high nibble of the top of the stack: palette index
;   low byte (+second highest nibble?) of the top of the stack: tile index
;   b: fill width
;   c: fill height
;   d: fill x
;   e: fill y
MACRO ER_FillBackgroundTile
    ld hl, (\1 << 8 + \2)
    push hl
    ld bc, (\5 << 8 + \6)
    ld de, (\3 << 8 + \4)
    LD_A_OPT \7
    ER_API ER_ID_FillBackgroundTile
    pop bc
ENDM

; ER_CustomBackground:
;   Struct representing the data required to draw a custom background
struct ER_CustomBackground
    words 1, TilePtr
    words 1, PalettePtr
    words 1, MapPtr
    words 1, TileCount
    words 1, PaletteCount
end_struct

; ER_LoadCustomBackground:
;   Loads a custom background made of tiles, palettes and a map
;
;   TODO: More research is needed on the tilemap
;   The custom background will use a palette index based on the background index
;     bg 0: palette 0
;     bg 1: palette 4
;     bg 2: palette 8
;     bg 3: palette 12
;
;   a: background index
;   de: pointer to ER_CustomBackground struct
MACRO ER_LoadCustomBackground
    ld de, \1
    LD_A_OPT \2
    ER_API ER_ID_LoadCustomBackground
ENDM

; ER_SetSpritePos:
;   Moves a sprite on the screen. Must be called at least once after SpriteCreate
;   in order for the sprite to appear
;
;   hl: sprite handle
;   de: x in pixels
;   bc: y in pixels
MACRO ER_SetSpritePos
    ld bc, \3
    ld de, \2
    LD_HL_IND \1
    ER_API ER_ID_SetSpritePos
ENDM

; ER_SetSpritePosAnimatedDuration:
;   Animates the sprite to a new position over the given duration
;
;   hl: sprite handle
;   de: x in pixels (offset or actual?)
;   bc: y in pixels
;   LOW(sp): duration
MACRO ER_SetSpritePosAnimatedDuration ; handle x y duration
    ld l, \4
    push hl
    ld bc, \3
    ld de, \2
    LD_HL_IND \1
    ER_API ER_ID_SetSpritePosAnimatedDuration
    pop bc
ENDM

; ER_SpriteShow
;   Shows a previously hidden sprite
;
;   hl: sprite handle
MACRO ER_SpriteShow
    LD_HL_IND \1
    ER_API ER_ID_SpriteShow
ENDM

; ER_SpriteHide
;   Hides a visible sprite
;
;   hl: sprite handle
MACRO ER_SpriteHide
    LD_HL_IND \1
    ER_API ER_ID_SpriteHide
ENDM

DEF ER_SpriteMirrorToggle_None EQU 0
DEF ER_SpriteMirrorToggle_Horizontal EQU 1
DEF ER_SpriteMirrorToggle_Vertical EQU 2
DEF ER_SpriteMirrorToggle_Diagonal EQU 3
; ER_SpriteMirrorToggle:
;   Toggles horizontal, vertical, or both mirroring for a sprite. Mirroring
;   looks to be done with an affine transform, so just like scaling and
;   rotating, only early allocated sprites can mirror.
;
;   Bitmask:
;     0b00 - no mirror
;     0b01 - horizontal mirror
;     0b10 - vertical mirror
;     0b11 - both mirror
;
;   hl: sprite handle
;   e: bitmask
MACRO ER_SpriteMirrorToggle ; sprite handle, bitmask
    ld e, \2
    LD_HL_IND \1
    ER_API ER_ID_SpriteMirrorToggle
ENDM

; ER_CustomSprite:
;   Struct representing the data required to draw a custom sprite
struct ER_CustomSprite
    words 1, TilePtr
    words 1, PalettePtr
    bytes 1, Width ; In Tiles
    bytes 1, Height ; In Tiles
    bytes 1, FramesPerBank
    bytes 1, Unknown
    bytes 1, HitBoxWidth ; In Pixels
    bytes 1, HitBoxHeight ; In Pixels
    bytes 1, FrameCount
end_struct

; ER_SpriteCreate
;   Creates a new custom sprite
;
;   hl: pointer to ER_CustomSprite struct
;   e: palette index
;   returns handle in hl
MACRO ER_SpriteCreate ; handle ptr, palette index, ER_CustomSprite ptr
    ld e, \2
    ld hl, \3
    ER_API ER_ID_SpriteCreate
    ld_ind_hl \1
ENDM

DEF ER_Exit_Restart EQU 1
DEF ER_Exit_Menu EQU 2
; ER_Exit:
;   Exits the game and either resets or returns to menu
;
;   Exit Option:
;     1 - Restart app
;     2 - Exit to e-Reader menu
;
;   a: exit option
MACRO ER_Exit ; exit option
    ld a, \1
    ER_API ER_ID_Exit
ENDM

; ER_PlayStaticSystemSound:
;   Plays a system sound that must be known at compile time
;   This function is prefered when always playing the same audio
;   as it saves a byte over the dynamic version
;
;  rom: Song id to play
MACRO ER_PlayStaticSystemSound ; song_id
    ER_API ER_ID_PlayStaticSystemSound
    dw \1
ENDM

MACRO SpriteAutoScaleUntilSize
    ld c, \2
    ld de, \3
    LD_HL_IND \1
    ER_API ER_ID_SpriteAutoScaleUntilSize
    ENDM
MACRO SetBackgroundPalette
    ld c, \1
    ld de, \2
    ld hl, \3
    ER_API ER_ID_SetBackgroundPalette
    ENDM
MACRO ER_API_084
    ld l, \4
    push hl
    ld bc, \3
    ld de, \2
    LD_HL_IND \1
    ER_API ER_ID_Unk084
    ENDM
MACRO CreateRegion
    ld bc, (\2 << 8 + \3)
    ld de, (\4 << 8 + \5)
    ld hl, (\6 << 8 + \7)
    ER_API ER_ID_CreateRegion
    LD_IND_A \1
    ENDM
MACRO SetRegionColor
    ld e, \2
    LD_A_IND \1
    ER_API ER_ID_SetRegionColor
    ENDM
MACRO CLEAR_REGION
    LD_A_IND \1
    ER_API ER_ID_ClearRegion
    ENDM
MACRO SetTextColor
    ld de, (\2 << 8 + \3)
    LD_A_IND \1
    ER_API ER_ID_SetTextColor
    ENDM
MACRO DrawText
    CLEAR_REGION \1
    ld bc, \2
    ld de, (\3 << 8 + \4)
    LD_A_IND \1
    ER_API ER_ID_DrawText
    ENDM

DEF ER_SetTextSize_Small EQU 0
DEF ER_SetTextSize_Medium EQU 1
DEF ER_SetTextSize_Large EQU 2
; ER_SetTextSize:
;   Sets the size of the text in the region
;   Warning: Has been known to not work/lock up the system
;
;   Text Size:
;     0 - Small
;     1 - Medium
;     2 - Large
;
;   h: region handle
;   l: text size
MACRO ER_SetTextSize ; handle, size
    ld h, \1
    ld l, \2
    ER_API ER_ID_SetTextSize
ENDM

; ER_SetTextSizeA:
;   See ER_SetTextSize except handle is assumed
;   to already be in A
MACRO ER_SetTextSizeA ; size
    ld h, a
    ld l, \1
    ER_API ER_ID_SetTextSize
ENDM

; ER_IncreaseTextKerning:
;   Increases the number of pixels between each letter in the region.
;   initial kerning is 1,1
;
;   d: x kerning increase
;   e: y kerning increase
;   a: region handle
MACRO ER_IncreaseTextKerning ; handle, x, y
    ld de, (\2 << 8 + \3)
    LD_A_IND \1
    ER_API ER_ID_SetTextSpacing
ENDM

MACRO GetTextWidth
    ld de, \2
    LD_A_IND \1
    ER_API ER_ID_GetTextWidth
    ENDM
MACRO ER_API_0C7
    ld hl, \1
    ER_API ER_ID_Unk0C7
    ENDM

; ER_StopSong
;
; de/hl Song index/fade out time
MACRO ER_StopSong
    ld de, \1
    ld hl, \2
    ER_API ER_ID_StopSong
ENDM

MACRO SOUND_PAUSE
    ER_API ER_ID_PauseSound
    ENDM
MACRO SuppressPauseScreen
    ld de, $0000
    ld hl, $0000
    ER_API ER_ID_SupressPauseScreen
    ENDM
MACRO UnsuppressPauseScreen
    ld de, $0000
    ld hl, $0008
    ER_API ER_ID_SupressPauseScreen
    ENDM
