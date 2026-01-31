    wait 32
    ld l, $02
    push hl
    ld bc, $B9A0
    ld de, $0076
    ld a, $08
    ER_API ER_ID_Unk0C4
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
    waita $01
    GF_JumpIfNotPressed $02, .asm_1b90
    GF_PlaySystemSoundThenExit $0006, ER_Exit_Menu

.asm_1b90
    ER_API ER_ID_Unk0CA
    cp $02
    jr c, .asm_1b76
