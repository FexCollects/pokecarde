INCLUDE "include/gba.asm"
INCLUDE "include/structs.inc"
INCLUDE "constants/card_types.asm"
INCLUDE "constants/regions.asm"

rgbds_structs_version 4.1.0
def STRUCT_SEPARATOR equs "."

struct BerryData
    bytes 7, Name
    bytes 1, Firmness
    words 1, Size
    bytes 1, MaxYield
    bytes 1, MinYield
    longs 2, Description
    bytes 1, StageDuration
    bytes 1, Spicy
    bytes 1, Dry
    bytes 1, Sweet
    bytes 1, Bitter
    bytes 1, Sour
    bytes 1, Smoothness
end_struct

MACRO Enigma_Berry
    CardHeader CUSTOM_BERRY
    dl $02000018 ; GBAPtr
    db $02,$00
    ENDM

; firmness
DEF VERY_SOFT  EQU 1
DEF SOFT       EQU 2
DEF HARD       EQU 3
DEF VERY_HARD  EQU 4
DEF SUPER_HARD EQU 5

DEF End_Berry EQUS "dl"
