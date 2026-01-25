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

dstruct BoxPokemon, \
  PokemonStart, \
    .Personality=SHINY_ADAMANT_MALE, \
    .OTTID=00000, \
    .OTSID=00000, \
    .Name="BELDUM@   ", \
    .Language=$02, \
    .Flags=$02, \
    .OTName="STEVEN@", \
    .Markings=0, \
    .Checksum=0, \
    .Unknown=0, \
    .Species=BELDUM, \
    .HeldItem=ITEM_NONE, \
    .Experience=156, \
    .PPUps=0, \
    .Friendship=0, \
    .Unknown2=0, \
    .Moves=METEOR_MASH\, SHADOW_BALL\, EARTHQUAKE\, SLUDGE_BOMB, \
    .PP=10\, 15\, 10\, 15, \
    .HPEV=0, \
    .AttackEV=255, \
    .DefenseEV=0, \
    .SpeedEV=0, \
    .SpAttackEV=255, \
    .SpDefenseEV=0, \
    .Cool=0, \
    .Beauty=0, \
    .Cute=0, \
    .Smart=0, \
    .Tough=0, \
    .Sheen=0, \
    .Pokerus=0, \
    .MetLocation=$FF, \
    .Origins=8581, \
    .IVs=$3FFFFFFF, \
    .Ribbons=0, \
    .Status=0, \
    .Level=5, \
    .Mail=0, \
    .CurrentHP=20, \
    .MaxHP=20, \
    .Attack=16, \
    .Defense=14, \
    .Speed=9, \
    .SpAttack=9, \
    .SpDefense=15, \

    End_GiftPokemon ;Use End_GiftEgg if sending egg

DataEnd:
    db 0,0,0 ; padding

POPC
