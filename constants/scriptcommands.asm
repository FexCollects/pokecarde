DEF LASTRESULT EQU $800D
MACRO end
	db $02
	ENDM
MACRO return
	db $03
	ENDM
MACRO goto
	db $05
	dd \1
	ENDM
MACRO goto_if
	db $06
	db \1
	dd \2
	ENDM
MACRO call_if
	db $07
	db \1
	dd \2
	ENDM
MACRO gotostd
	db $08
	db \1
	ENDM
MACRO callstd
	db $09, \1
	ENDM
MACRO gotostd_if
	db $0A
	db \1
	db \2
	ENDM
MACRO callstd_if
	db $0B
	db \3
	db \2
	ENDM
MACRO returnram
	db $0C
	ENDM
MACRO killscript
	db $0D
	ENDM
MACRO setbyte
	db $0E, \1
	ENDM
MACRO loadword
	db $0F
	db \1
	dd \2
	ENDM
MACRO loadbyte
	db $10
	db \1
	db \2
	ENDM
MACRO writebytetoaddr
	db $11
	db \1
	dd \2
	ENDM
MACRO loadbytefromaddr
	db $12
	db \1
	dd \2
	ENDM
MACRO setptrbyte
	db $13
	db \1
	dd \2
	ENDM
MACRO copylocal
	db $14
	db \1
	db \2
	ENDM
MACRO copybyte
	db $15
	dd \1
	dd \2
	ENDM
MACRO setvar
	db $16
	dw \1
	dw \2
	ENDM
MACRO addvar
	db $17
	dw \1
	dw \2
	ENDM
MACRO subvar
	db $18
	dw \1
	dw \2
	ENDM
MACRO copyvar
	db $19
	dw \1
	dw \2
	ENDM
MACRO copyvarifnotzero
	db $1A
	dw \1, \2
	ENDM
MACRO compare
	db $21
	dw \1, \2
	ENDM
MACRO setflag
	db $29
	dw \1
	ENDM
MACRO checkflag
	db $2B
	dw \1
	ENDM
MACRO playfanfare
	db $31
	dw \1
	ENDM
MACRO waitfanfare
	db $32
	ENDM
MACRO getpartysize
	db $43
	ENDM
MACRO additem
	db $44
	dw \1, \2
	ENDM
MACRO checkitemroom
	db $46
	dw \1, \2
	ENDM
MACRO checkitem
	db $47
	dw \1, \2
	ENDM
MACRO checkpcitem
	db $4A
	dw \1, \2
	ENDM
MACRO adddecoration
	db $4b
	dw \1
	ENDM
MACRO faceplayer
	db $5A
	ENDM
MACRO waitmsg
	db $66
	ENDM
MACRO lock
	db $6A
	ENDM
MACRO release
	db $6C
	ENDM
MACRO waitkeypress
	db $6D
	ENDM
MACRO showmonpic
	db $75
	dw \1
	db \2
	db \3
	ENDM
MACRO hidemonpic
	db $76
	ENDM
MACRO showcontestpainting
	db $77
	db \1
	ENDM
MACRO braillemessage
	db $78
	dd \1
	ENDM
MACRO brailleformat
	db \1
	db \2
	db \3
	db \4
	db \5
	db \6
	ENDM
MACRO givemon
	db $79
	dw \1
	db \2
	dw \3
	dd \4
	dd \5
	db \6
	ENDM
MACRO giveegg
	db $7A
	dw \1
	ENDM
MACRO setmonmove
	db $7b
	db \1
	db \2
	dw \3
	ENDM
MACRO checkpartymove
	db $7c
	dw \1
	ENDM
MACRO bufferspeciesname
	db $7d
	db \1
	dw \2
	ENDM
MACRO bufferleadmonspeciesname
	db $7E
	db \1
	ENDM
MACRO bufferpartymonnick
	db $7f
	db \1
	dw \2
	ENDM
MACRO bufferitemname
	db $80
	db \1
	dw \2
	ENDM
MACRO bufferdecorationname
	db $81
	db \1
	dw \2
	ENDM
MACRO buffermovename
	db $82
	db \1
	dw \2
	ENDM
MACRO random
	db $8F
	dw \1
	ENDM
MACRO setrespawn
	db $9F
	dw \1
	ENDM
MACRO checkplayergender
	db $A0
	ENDM
MACRO playmoncry
	db $A1
	dw \1
	dw \2
	ENDM
MACRO setwildbattle
	db $B6
	dw \1
	db \2
	dw \3
	ENDM
MACRO dowildbattle
	db $B7
	ENDM
MACRO setvirtualaddress
	db $B8
	GBAPTR \1
	ENDM
MACRO virtualgotoif
	db $BB
	db \1
	GBAPTR \2
	ENDM
MACRO virtualmsgbox
	db $BD
	GBAPTR \1
	ENDM
MACRO virtualloadpointer
	db $BE
	GBAPTR \1
	ENDM
MACRO waitmoncry
	db $C5
	ENDM
MACRO setmoneventlegal
	db $CD
	dw \1
	ENDM
MACRO checkmoneventlegal
	db $CE
	dw \1
	ENDM
MACRO setmonmetlocation
	db $D2
	dw \1
	db \2
	ENDM
