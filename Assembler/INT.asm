DATA SEGMENT
    
DATA ENDS
 

STACK SEGMENT

STACK ENDS



CODE SEGMENT 
START:
    ;设置中断向量
    MOV [40H*4+2],SEG COPY ;段地址
    MOV [40H*4]], OFFSET COPY ;偏移地址

    CALL COPY
    HLT
 
COPY  PROC
    IRET
COPY ENDP


CODE ENDS 
 
END START
