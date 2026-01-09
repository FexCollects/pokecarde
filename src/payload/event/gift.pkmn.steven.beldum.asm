SECTION "payload/event/gift.pkmn.steven.beldum", ROM0
INCLUDE "constants/abilities.asm"
INCLUDE "constants/moves.asm"
INCLUDE "constants/natures.asm"
INCLUDE "constants/pokemon.asm"
INCLUDE "include/event.asm"
INCLUDE "include/gift.pkmn.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Mystery_Event
    GBAPtr DataStart
    GBAPtr DataEnd

DataStart:
    db GIVE_POKEMON
    GBAPtr PokemonStart
    db END_OF_CHUNKS

PokemonStart:
    PV SHINY_ADAMANT_MALE
    OT_ID 00000, 00000
    db "BELDUM@   "
    Language $0202    ;Language $0201=JP $0202=EN $0203=FR $0204=IT $0205=DE $0206=KR $0207=ES $0601=EGG
    db "STEVEN@"
    Markings 0
    dw 0 ;Checksum, computed later
    dw 0 ;Unknown

;Substruct1
    Pokemon BELDUM
    Holds ITEM_NONE
    Experience 156
    PP_Ups 0,0,0,0
    Friendship 0
    dw 0 ;Unknown

;Substruct2
    Moves METEOR_MASH, SHADOW_BALL, EARTHQUAKE, SLUDGE_BOMB
    PP 10, 15, 10, 15

;Substruct3
    EVs 0,255,0,0,255,0
    Condition 0,0,0,0,0,0    ;i.e. Contest Condition

;Substruct4
    PokerusStatus 0
    MetLocation $FF
    Origins 5,3,4,0  ;Lv met, Game of Origin, Ball, OT Gender
    IVs 31,31,31,31,31,31, BELDUM_CLEAR_BODY
    Ribbons 0

    dl 0  ;Status condition
    db 5  ;Lv
    db 0  ;pokerus remaining
    dw 20 ;Current HP
    dw 20 ;Total HP
    dw 16 ;Attack
    dw 14 ;Def
    dw 9  ;Speed
    dw 9  ;Sp Atk
    dw 15 ;Sp Def

    End_GiftPokemon ;Use End_GiftEgg if sending egg

DataEnd:
    db 0,0,0 ; padding

POPC
