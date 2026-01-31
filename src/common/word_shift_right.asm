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
