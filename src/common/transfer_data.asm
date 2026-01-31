.asm_1bfe
    waita $01

    ld hl, Space_3
    ER_API ER_ID_Unk0C8

    or a
    jr nz, .asm_1c18

    GF_PlaySystemSoundThenExit $0006, ER_Exit_Restart

.asm_1c18
    LD_HL_IND Space_3
    ld_ind_hl Space_4
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
