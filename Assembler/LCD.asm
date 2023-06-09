RS EQU 0B0h				;P3.0
	RW EQU 0B1H				;P3.1
	E EQU 0B2H					;P3.2
	CS1 EQU 0B4H				;P3.4
	CS2 EQU 0B5H				;P3.5
;*****************************************************
  	ORG 0000H
RST: 		MOV R7, #04H
	LCALL DELAYXMS
	CLR E
	SETB RS
	SETB CS1					;SELECT-CS1
	CLR CS2
	CLR RS
	MOV P1, #3FH 				;DISPLAY ON
	LCALL WRITE
	MOV R7, #01H
	SETB CS2					;SELECT-CS2
	CLR CS1
	CLR RS
	MOV P1, #3FH 				;DISPLAY ON
	LCALL WRITE
MAIN:		MOV R7, #0FH
	MOV DPTR, #TAB5
	LCALL ZXL
	MOV R7,#03FH
	LCALL DELAYXMS
	MOV DPTR,#TAB6
	LCALL ZXL
	MOV R7,#03FH
	LCALL DELAYXMS
	LJMP MAIN
;***************************************************
ZXL:		CLR CS2
	SETB CS1					;S-CS1
	LCALL XPAGE				;R0=08H,R2=B8H,Z=Y=PAG=00
	LCALL COM
	CLR CS1
	SETB CS2
	LCALL XPAGE
	LCALL COM
	RET
	;*****************************************************
XPAGE:    CLR E
		CLR RS
	MOV P1, #0C0H				;SET-Z=00,FIRST H
	LCALL WRITE
	MOV P1, #40H				;SET-Y=00,FIRST L
	LCALL WRITE
	MOV R0, #08H
	MOV R2, #0B8H
	MOV P1, #0B8H				;SET-PAG=00
	LCALL WRITE
		RET
;******************************************************
COM:  		CLR 00H
COM1:		MOV R1, #40H				;R0=#08H,R2=#0B8H
		MOV R3,#10H
		SETB RS					;WR-DATA
PUSH DPH
PUSH DPL
	J4:  		CLR A
	MOVC A, @A+DPTR			;DPTR=#TAB5
	MOV P1, A
	LCALL WRITE
	INC DPTR
	DJNZ R3,J41
	MOV R3,#10H
	CLR C
	MOV A,DPL
	ADD A,#10H
	MOV DPL,A
	JNC J41
	INC DPH
J41:		DJNZ R1, J4				;LOAD-64-BYTE
	CLR RS						;WR-COMD
	INC R2
	MOV P1, R2
	LCALL WRITE				;SET-PAG=01
	MOV P1, #40H				;SET-Y=00H
	LCALL WRITE
POP DPL
POP DPH
	CPL 00H
	JNB 00H,J43
	CLR C
	MOV A,DPL
	ADD A,#10H
	MOV DPL,A
	JNC J42
	INC DPH
		AJMP J42
J43:		CLR C
	MOV A,DPL
	ADD A,#70H
	MOV DPL,A
	JNC J42
	INC DPH
J42:   	DJNZ R0, COM1
		RET
;***************************************************
WRITE:  	CLR RW
	CLR E
	SETB E
	LCALL DELAY2MS
	CLR E
	RET
;*********************************
DELAY2MS:	MOV R6, #02H
DELAY0: 	MOV R5, #0FH
DELAY1: 	DJNZ R5, DELAY1
		DJNZ R6, DELAY0
		RET
;*************************************
DELAYXMS: 	MOV R5, #40H
D1: 		MOV R6, #0FFH
D2: 		DJNZ R6, D2
		DJNZ R5, D1
		DJNZ R7, DELAYXMS
		RET
TAB6:
TAB5:   
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
;--  文字:  欢  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  14H,24H,44H,84H,64H,1CH,20H,18H,0FH,0E8H,08H,08H,28H,18H,08H,00H
DB  20H,10H,4CH,43H,43H,2CH,20H,10H,0CH,03H,06H,18H,30H,60H,20H,00H

;--  文字:  迎  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  40H,41H,0CEH,04H,00H,0FCH,04H,02H,02H,0FCH,04H,04H,04H,0FCH,00H,00H
DB  40H,20H,1FH,20H,40H,47H,42H,41H,40H,5FH,40H,42H,44H,43H,40H,00H

;--  文字:  启  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,00H,0F8H,48H,48H,48H,49H,4EH,4AH,48H,48H,48H,78H,00H,00H
DB  40H,20H,18H,07H,00H,7EH,22H,22H,22H,22H,22H,22H,22H,7EH,00H,00H

;--  文字:  东  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,04H,04H,0C4H,0B4H,8CH,87H,84H,0F4H,84H,84H,84H,84H,04H,00H,00H
DB  00H,00H,20H,18H,0EH,04H,20H,40H,0FFH,00H,02H,04H,18H,30H,00H,00H

;--  文字:  东  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,04H,04H,0C4H,0B4H,8CH,87H,84H,0F4H,84H,84H,84H,84H,04H,00H,00H
DB  00H,00H,20H,18H,0EH,04H,20H,40H,0FFH,00H,02H,04H,18H,30H,00H,00H

;--  文字:  疆  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  01H,79H,49H,49H,0CFH,00H,01H,7DH,55H,55H,7DH,55H,55H,7DH,01H,00H
DB  12H,2FH,4AH,20H,1FH,40H,41H,5FH,55H,55H,5FH,55H,55H,5FH,41H,00H

;--  文字:  限  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  0FEH,02H,32H,4EH,82H,00H,0FEH,4AH,0CAH,4AH,4AH,4AH,7EH,00H,00H,00H
DB  0FFH,00H,02H,04H,03H,00H,0FFH,40H,20H,03H,0CH,12H,21H,60H,20H,00H

;--  文字:  公  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,80H,40H,30H,0EH,84H,00H,00H,0EH,10H,60H,0C0H,80H,80H,00H
DB  00H,01H,20H,70H,28H,24H,23H,31H,10H,10H,14H,78H,30H,01H,00H,00H

;--  文字:  司  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,10H,92H,92H,92H,92H,92H,92H,92H,92H,12H,02H,02H,0FEH,00H,00H
DB  00H,00H,1FH,04H,04H,04H,04H,04H,04H,0FH,00H,20H,40H,3FH,00H,00H

;--  文字:  生  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,80H,60H,1EH,10H,10H,10H,10H,0FFH,12H,10H,10H,98H,10H,00H,00H
DB  01H,40H,40H,41H,41H,41H,41H,41H,7FH,41H,41H,41H,41H,61H,40H,00H

 	;--  文字:  系  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,02H,22H,0B2H,0AAH,66H,62H,22H,11H,4DH,81H,01H,01H,00H,00H
DB  00H,40H,21H,13H,09H,05H,41H,81H,7FH,01H,05H,09H,13H,62H,00H,00H

;--  文字:  列  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  02H,82H,42H,0BAH,16H,12H,92H,7AH,12H,00H,0F8H,00H,00H,0FFH,00H,00H
DB  41H,40H,20H,10H,09H,06H,01H,00H,00H,00H,07H,20H,40H,3FH,00H,00H

 ;--  文字:  实  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,10H,0CH,04H,4CH,0B4H,94H,05H,0F6H,04H,04H,04H,14H,0CH,04H,00H
DB  00H,82H,82H,42H,42H,23H,12H,0AH,07H,0AH,12H,0E2H,42H,02H,02H,00H

;--  文字:  验  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  02H,0FAH,82H,82H,0FEH,80H,40H,60H,58H,46H,48H,50H,20H,20H,20H,00H
DB  08H,08H,04H,24H,40H,3FH,22H,2CH,21H,2EH,20H,30H,2CH,23H,20H,00H

;--  文字:  使  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  40H,20H,0F0H,1CH,07H,0F2H,94H,94H,94H,0FFH,94H,94H,94H,0F4H,04H,00H
DB  00H,00H,7FH,00H,40H,41H,22H,14H,0CH,13H,10H,30H,20H,61H,20H,00H

;--  文字:  用  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,00H,0FEH,22H,22H,22H,22H,0FEH,22H,22H,22H,22H,0FEH,00H,00H
DB  80H,40H,30H,0FH,02H,02H,02H,02H,0FFH,02H,02H,42H,82H,7FH,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H


;--  文字:  计  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  20H,21H,2EH,0E4H,00H,00H,20H,20H,20H,20H,0FFH,20H,20H,20H,20H,00H
DB  00H,00H,00H,7FH,20H,10H,08H,00H,00H,00H,0FFH,00H,00H,00H,00H,00H

;--  文字:  算  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB 08H,07H,0FAH,0AAH,0AEH,0AAH,0AAH,0A8H,0ACH,0ABH,0AAH,0FEH,0AH,02H,02H,00H
DB  08H,08H,8BH,6AH,1EH,0AH,0AH,0AH,0AH,0FEH,0AH,0BH,08H,08H,08H,00H

 ;--  文字:  机  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  08H,08H,0C8H,0FFH,48H,88H,08H,00H,0FEH,02H,02H,02H,0FEH,00H,00H,00H
DB  04H,03H,00H,0FFH,00H,41H,30H,0CH,03H,00H,00H,00H,3FH,40H,78H,00H

;--  文字:  有  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,04H,84H,44H,0E4H,34H,2CH,27H,24H,24H,24H,0E4H,04H,04H,04H,00H
DB  02H,01H,00H,00H,0FFH,09H,09H,09H,29H,49H,0C9H,7FH,00H,00H,00H,00H

;--  文字:  产  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,04H,0E4H,44H,4CH,74H,54H,45H,46H,64H,54H,4CH,44H,64H,44H,00H
DB  40H,30H,0FH,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H

;--  文字:  的  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,0F8H,8CH,8BH,88H,0F8H,40H,30H,8FH,08H,08H,08H,08H,0F8H,00H,00H
DB  00H,7FH,10H,10H,10H,3FH,00H,00H,00H,03H,26H,40H,20H,1FH,00H,00H

;--  文字:  D  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  08H,0F8H,08H,08H,08H,10H,0E0H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB  20H,3FH,20H,20H,20H,10H,0FH,00H,00H,00H,00H,00H,00H,00H,00H,00H


;--  文字:  J  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,08H,08H,0F8H,08H,08H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB  0C0H,80H,80H,80H,7FH,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H

;--  文字:  仪  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  40H,20H,0F0H,0CH,03H,00H,38H,0C0H,01H,0EH,04H,0E0H,1CH,00H,00H,00H
DB  00H,00H,0FFH,00H,40H,40H,20H,10H,0BH,04H,0BH,10H,20H,60H,20H,00H

;--  文字:  器  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  40H,40H,4FH,49H,49H,0C9H,0CFH,70H,0C0H,0CFH,49H,59H,69H,4FH,00H,00H
DB  02H,02H,7EH,45H,45H,44H,7CH,00H,7CH,44H,45H,45H,7EH,06H,02H,00H

;--  文字:  ！  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,00H,0F0H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB  00H,00H,00H,5FH,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H

;--  文字:  ！  --
;--  宋体12;  此字体下对应的点阵为：宽x高=16x16   --
DB  00H,00H,00H,0F0H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB  00H,00H,00H,5FH,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
END
