CODE 		SEGMENT           ;H8253.ASM
ASSUME 	CS:	CODE
ORG 1290H
START:		JMP TCONT
TCONTRO EQU 0043H
TCON0	 EQU 0040H
TCONT:		MOV DX,TCONTRO	;8253控制口
	MOV AL,36H			;命令字,计数器0,先低后高,方式3,HEX
	OUT DX,AL			;写命令字
	
MOV DX,TCON0		;T0口
	MOV AL,00H			;计数器低位值
	OUT DX,AL
	MOV AL,04H			;计数器高位值
	OUT DX,AL
JMP $
CODE ENDS
END  START
