STACKS SEGMENT PARA STACK 'STACK'
        DW 256 DUP(?) ;��ջֻ����һ����һ���ֵĲ���,��Ԥ����ջ�ռ�
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,SS:STACKS
START:
    MOV AX,STACKS  ;�������STACKS,��ǰ����DATAS
    MOV SS,AX      ;�������SS�ˣ���ǰ������DS
    MOV CX,10   ;����10���ַ�=>��ջ
READ:
    MOV AH,01H
    INT 21H
    PUSH AX    ;��ջ�������ǡ��֡���������AL���˷���AH�Ŀռ�
    LOOP READ  ;��10���ַ�

    MOV DL,0AH  ;��ʾ�س�
    MOV AH,02H
    INT 21H
    MOV DL,0DH  ;��ʾ����
    INT 21H

    MOV CX,10   ;��ջ�����ε���10���ַ����
DISP:
    POP DX      ;��ʾ
    MOV AH,02H
    INT 21H
    LOOP DISP  ;��ʾ10���ַ�

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START