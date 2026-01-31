INCLUDE "include/erapi.asm"

; GF_PlaySystemSoundThenExit:
;   Helper function that does three erapi tasks
;   1: Starts playing the provided system sound
;   2: Waits for the sound to complete
;   3: Exits the application with the given mode
MACRO GF_PlaySystemSoundThenExit ; sound id, exit mode
    ER_PlayStaticSystemSound \1

    ld e, $01
    ld hl, \1
    ER_API ER_ID_IsSoundPlaying

    ld a, \2
    ER_API ER_ID_Exit
ENDM

; GF_JumpIfNotPressed:
;   Helper function that reads the current keys
;   and jumps to the given address if the key isn't
;   pressed
MACRO GF_JumpIfNotPressed ; key, address
    LD_HL_IND ER_KEY_INPUT_NEW
    ld a, l
    and \1 
    jr z, \2 
ENDM

; GF_JumpIfPressed:
;   Helper function that reads the current keys
;   and jumps to the given address if the key is
;   pressed
MACRO GF_JumpIfPressed ; key, address
    LD_HL_IND ER_KEY_INPUT_NEW
    ld a, l
    and \1 
    jr nz, \2 
ENDM
