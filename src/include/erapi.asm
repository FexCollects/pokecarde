INCLUDE "include/z80.asm"

MACRO API
        ; If the api number is less than $100 use rst 0 otherwise use rst 8
        ; Doing this instead of having an API_0 and API_8 simplifies the call
        ; stack at the cost of slightly renaming api numbers from publicaly
        ; available documentation
    IF \1 < $100
        rst 0
    ELSE
        rst 8
    ENDC

        ; remove the upper bit which was only used to pick the rst
    db (\1 & $FF)
    ENDM

; names for some API functions based on Martin Korth’s GBATEK
; http://problemkaputt.de/gbatek.htm
MACRO FadeIn
    ld a, \1
    API $000
    ENDM
MACRO SetBackgroundAutoScroll
    ld bc, \1
    ld de, \2
    xor a
    API $012
    ENDM
MACRO SetBackgroundMode
    ld e, \1
    push de
    xor a
    API $019
    ENDM
; TileFillBackground paletteIdx tile x y width height layer
MACRO TileFillBackground
;BackgroundTileFill:
;  Fills a portion of the screen with a tile in a specified background layer 
;  The api call doesn't pop the stack so you have to manually pop it
;  Params:
;    high nibble of the top of the stack: palette index
;    low byte (+second highest nibble?) of the top of the stack: tile index
;    b: fill width
;    c: fill height
;    d: fill x
;    e: fill y
    ld hl, (\1 << 8 + \2)
    push hl
    ld bc, (\5 << 8 + \6)
    ld de, (\3 << 8 + \4)
    IF \7 == 0
        xor a ; save a byte
    ELSE
        ld a, \7
    ENDC
    API $02C
        pop bc
    ENDM
MACRO LoadCustomBackground
    ld de, \1
    IF \2 == 0
        xor a ; save a byte
    ELSE
        ld a, \2
    ENDC
    API $02D
    ENDM
MACRO SetSpritePos
    ld bc, \3
    ld de, \2
    LD_HL_IND \1
    API $032
    ENDM
MACRO SpriteShow
    LD_HL_IND \1
    API $046
    ENDM
MACRO SpriteHide
    LD_HL_IND \1
    API $047
    ENDM
MACRO SpriteMirrorToggle
    ld e, \1
    LD_HL_IND \2
    API $048
    ENDM
MACRO CreateCustomSprite
    ld e, \2
    ld hl, \3
    API $04D
    LD_IND_HL \1
    ENDM
MACRO SpriteAutoScaleUntilSize
    ld c, \2
    ld de, \3
    LD_HL_IND \1
    API $05B
    ENDM
MACRO SetBackgroundPalette
    ld c, \1
    ld de, \2
    ld hl, \3
    API $07E
    ENDM
MACRO API_084
    ld l, \4
    push hl
    ld bc, \3
    ld de, \2
    LD_HL_IND \1
    API $084
    ENDM
MACRO CreateRegion
    ld bc, (\2 << 8 + \3)
    ld de, (\4 << 8 + \5)
    ld hl, (\6 << 8 + \7)
    API $090
    LD_IND_A \1
    ENDM
MACRO SetRegionColor
    ld e, \2
    LD_A_IND \1
    API $091
    ENDM
MACRO CLEAR_REGION
    LD_A_IND \1
    API $092
    ENDM
MACRO SetTextColor
    ld de, (\2 << 8 + \3)
    LD_A_IND \1
    API $098
    ENDM
MACRO DrawText
    CLEAR_REGION \1
    ld bc, \2
    ld de, (\3 << 8 + \4)
    LD_A_IND \1
    API $099
    ENDM
MACRO SetTextSize
    API $09A
    ENDM
; IncreaseTextKerning ($9B rst 0)
; Increases the number of pixels between each letter in the region.
;  initial kerning is 1,1
; Params
; d: x kerning
; e: y kerning
; a: region handle
MACRO IncreaseTextKerning
    ld de, (\2 << 8 + \3)
    LD_A_IND \1
    API $09B
    ENDM
MACRO GetTextWidth
    ld de, \2
    LD_A_IND \1
    API $0C0
    ENDM
MACRO API_0C7
    ld hl, \1
    API $0C7
    ENDM
MACRO EXIT
    API $100
    ENDM
MACRO API_106
    ld de, \1
    ld hl, \2
    API $106
    ENDM
MACRO SOUND_PAUSE
    API $116
    ENDM
MACRO IS_SOUND_PLAYING
    API $08D
    ld b, $00
    ld e, $01
    ld hl, $0006
    API $119
    ld a, \1
    EXIT
    ENDM
MACRO SuppressPauseScreen
    ld de, $0000
    ld hl, $0000
    API $121
    ENDM
MACRO UnsuppressPauseScreen
    ld de, $0000
    ld hl, $0008
    API $121
    ENDM
