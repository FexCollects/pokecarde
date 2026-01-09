DEF GBABaseAddress = $02000000 

MACRO GBAPtr
    dl GBABaseAddress + \1 - ScriptBaseAddress
    ENDM

MACRO CardHeader
ScriptBaseAddress:
    db $01
    dl GBABaseAddress
    db REGION,0,REGION,0,0,0,$04,0,$80,$01,0,0
    db \1 
    ENDM
