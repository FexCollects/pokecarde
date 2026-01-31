WrapUp:
.check_a_pressed
    waita 1

    GF_JumpIfNotPressed ER_KEY_A, .check_b_pressed
    GF_PlaySystemSoundThenExit $0005, ER_Exit_Restart

    jr .check_a_pressed

.check_b_pressed
    GF_JumpIfNotPressed ER_KEY_B, .check_a_pressed
    GF_PlaySystemSoundThenExit $0006, ER_Exit_Menu

    jr .check_a_pressed
