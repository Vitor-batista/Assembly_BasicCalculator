DATA SEGMENT
	M1 DB ?
	M2 DB ?
	MR DB ?
	MSG_I DB "* * * * * * * * * * *",10,13,"*                   *",10,13,"* 1 - Soma          *",10,13,"* 2 - Subtracao     *",10,13,"* 3 - Multiplicacao *",10,13,"* 4 - Divisao       *",10,13,"*                   *",10,13,"* * * * * * * * * * *",10,13,10,13,"$"
	MSG_ADD DB " + $"
	MSG_SUB DB " - $"
	MSG_DIV DB " / $"
	MSG_MUL DB " * $"
	MSG_EQU DB " = $"
	MSG_ST DB "DIGITE O PRIMEIRO NUMERO DA CONTA",10,13,"$"
	MSG_ND DB "DIGITE O SEGUNDO NUMERO DA CONTA",10,13,"$"
	T_ADD DB "* * * ESCOLHEU SOMA * * *",10,13,10,13,"$"
	T_SUB DB "* * * ESCOLHEU SUBTRACAO * * *",10,13,10,13,"$"
	T_MUL DB "* * * ESCOLHEU MULTIPLICACAO * * *",10,13,10,13,"$"
	T_DIV DB "* * * ESCOLHEU DIVISAO * * *",10,13,10,13,"$"
	MSG_NULL DB "NUNHUMA OPCAO SELECIONADA",10,13,"A SAIR...",10,13,"$"
	MOV AH, 9H	
	INT 21H
	SPC DB " ",10,13,"$"

ENDS

CODE SEGMENT
ASSUME DS:DATA, CS:CODE 

START:
	MOV AX, DATA				;PEGA AS STRINGS DO DS
	MOV DS, AX

	LEA DX, MSG_I				;ESCREVE A STRING
	MOV AH, 9H
	INT 21H

	MOV AH, 8H				;LÊ UM BYTE SEM ECHO
	INT 21H

	SUB AL, 48				;SUBTRAI 48 PARA DAR O VALOR NUMERICO

	CMP AL, 1				;COMPARA O BYTE COM "1"
	JE SOMA					;FAZ UM JUMP CASO O BYTE = 1
	
	CMP AL, 2				;COMPRAR O BYTE COM "2"
	JE SUBTRACAO				;FAZ UM JUMP CASO O BYTE = 1
	
	CMP AL, 3				;COMPRAR O BYTE COM "3"
	JE L2	
	JNE LC
L2:
	JMP MULTIPLICACAO			;FAZ UM JUMP CASO O BYTE = 1

LC:	
	CMP AL, 4				;COMPRAR O BYTE COM "3"
	JE L3	
	JNE LV
L3:
	JMP DIVISAO			;FAZ UM JUMP CASO O BYTE = 1

LV:	
	LEA DX, MSG_NULL			;SE NAO LER UM NUMERO DO MENU FECHA O PROGRAMA
	MOV AH, 9H
	INT 21H

	JMP EXIT				
	
SOMA:
	LEA DX, T_ADD				;ESCREVE QUE O ESCOLHIDO A SOMA
	MOV AH, 9H	
	INT 21H

	LEA DX, MSG_ST				;ESCREVE A MSG PARA SER ESCRITO O PRIMEIRO NUMERO
	MOV AH, 9H
	INT 21H

	MOV AH, 1H				;LÊ O BYTE COM ECHO
	INT 21H
	
	MOV BL, AL				;MOVE O VALOR DO PRIMEIRO NUMERO PARA BL
	
	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	LEA DX, MSG_ND				;ESCREVE A MSG PARA SER ESCRITO O SEGUNDO NUMERO
	MOV AH, 9H                       
	INT 21H

	MOV AH, 1H				;LÊ O BYTE COM EXHO
	INT 21H
	
	MOV CL, 0				;PARA LIMPAR E DEPOIS GUARDAR OS VALORES EM CL E BH
	MOV BH, 0
	ADD CL, AL
	ADD BH, BL
	
	SUB AL, 48				;TIRA 48 NO VALOR QUE ESTÁ EM AL E PARA FAZER A CONTA DOS VALORES((VALROES DEC)2 = 50 - 48 = 2// )
	
	ADD AL, BL				;FAZ A CONTA AL + BL  E GUARDA EM AL
	MOV DH, AL				;MOVE AL PARA DH
	MOV CH, 0				;LIMPA O CH
	ADD CH, DH				;METE O VALOR DE DH EM CH

;-----PARTE DO OUTPUT-----
	
	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	MOV DL, BH				;ESCREVE UM VALOR
	MOV AH, 2H
	INT 21H
	
	LEA DX, MSG_ADD				;ESCREVE "+"
	MOV AH, 9H
	INT 21H
		
	MOV DL, CL				;ESCREVE O OUTRO VALOR
	MOV AH, 2H
	INT 21H

	LEA DX, MSG_EQU				;ESCREVE "="
	MOV AH, 9H
	INT 21H
		
	MOV DL, CH				;ESCREVE O RESULTADO
	MOV AH, 2H				
	INT 21H

	JMP EXIT;				;JUMP PARA "EXIT"

;-----PARTE DO OUTPUT-----


SUBTRACAO:
	LEA DX, T_SUB				;ESCREVE QUE O ESCOLHIDO A SUBTRACAO
	MOV AH, 9H	
	INT 21H	

	LEA DX, MSG_ST				;ESCREVE A MSG PARA SER ESCRITO O PRIMEIRO NUMERO
	MOV AH, 9H
	INT 21H
	
	MOV AH, 1H				;LÊ O BYTE COM ECHO
	INT 21H
	
	MOV BL, AL				;MOVE O VALOR DO BYTE PARA BL

	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H
	
	LEA DX, MSG_ND				;ESCREVE A MSG PARA SER ESCRITO O SEGUNDO NUMERO
	MOV AH, 9H
	INT 21H
	
	MOV AH, 1H 				;LÊ O BYTE COM ECHO
	INT 21H
	
	MOV CL, 0				;PARA LIMPAR E DEPOIS GUARDAR OS VALORES EM CL E BH
	MOV BH, 0
	ADD CL, AL
	ADD BH, BL
	
	ADD BL, 48				;ADICIONA 48 NO VALOR QUE ESTÁ EM BL E PARA FAZER A CONTA DOS VALORES((VALROES DEC)2 = 50 - 48 = 2// )
	
	SUB BL, AL				;FAZ A CONTA AL + BL  E GUARDA EM AL
	MOV DH, BL				;MOVE AL PARA DH
	MOV CH, 0				;LIMPA O CH
	ADD CH, DH				;METE O VALOR DE DH EM CH

;-----PARTE DO OUTPUT-----
	
	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	MOV DL, BH				;ESCREVE UM VALOR
	MOV AH, 2H
	INT 21H
	
	LEA DX, MSG_SUB				;ESCREVE "-"
	MOV AH, 9H
	INT 21H
		
	MOV DL, CL				;ESCREVE O OUTRO VALOR
	MOV AH, 2H
	INT 21H

	LEA DX, MSG_EQU				;ESCREVE "="
	MOV AH, 9H
	INT 21H
		
	MOV DL, CH				;ESCREVE O RESULTADO
	MOV AH, 2H				
	INT 21H

	JMP EXIT;				;JUMP PARA "EXIT"

;-----PARTE DO OUTPUT-----

MULTIPLICACAO:
	LEA DX, T_MUL				;ESCREVE QUE O ESCOLHIDO A MULTIPLICACAO
	MOV AH, 9H	
	INT 21H	

	LEA DX, MSG_ST				;ESCREVE A MSG PARA SER ESCRITO O PRIMEIRO NUMERO
	MOV AH, 9H
	INT 21H
	
	MOV AH, 1H				;LÊ O BYTE COM ECHO
	INT 21H
	
	SUB AL,	48				;TIRA 48 AO VALOR DE AL E GURADA AL EM M1
	MOV M1, AL

	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	LEA DX, MSG_ND				;ESCREVE A MSG PARA SER ESCRITO O SEGUNDO NUMERO
	MOV AH, 9H
	INT 21H
	
	MOV AH, 1H 				;LÊ O BYTE COM ECHO
	INT 21H

	SUB AL, 48				;TIRA 48N AO VALOR DE AL
	MOV M2, AL				;GUARDA AL EM M2

	MUL M1					;MULTIPLICA M1 PELO M2, PQ M2 FOI PARA AL

	AAM					;PARA REORGANIZAR O AX

	ADD AH, 48				;PARA OS NUMEROS VOLTAREM A SER NUEMEROS EM TERMOS DECIMAIS
	ADD AL, 48
	ADD M1, 48
	ADD M2, 48
	
	MOV BX,AX				;METE AX EM BX PARA O OUTPUT
	
	

;-----PARTE DO OUTPUT-----
	
	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	MOV DL, M1				;ESCREVE UM VALOR
	MOV AH, 2H
	INT 21H
	
	LEA DX, MSG_MUL				;ESCREVE "*"
	MOV AH, 9H
	INT 21H
		
	MOV DL, M2				;ESCREVE O OUTRO VALOR
	MOV AH, 2H
	INT 21H

	LEA DX, MSG_EQU				;ESCREVE "="
	MOV AH, 9H
	INT 21H
		
	MOV AH, 2H				;ESCREVE O RTESULTADO
	MOV DL, BH
	INT 21H
	MOV AH, 2H
	MOV DL, BL	
	INT 21H	
	JMP EXIT;				;JUMP PARA "EXIT"

;-----PARTE DO OUTPUT-----

DIVISAO:
	LEA DX, T_DIV				;ESCREVE QUE O ESCOLHIDO A MULTIPLICACAO
	MOV AH, 9H	
	INT 21H	

	LEA DX, MSG_ST				;ESCREVE A MSG PARA SER ESCRITO O PRIMEIRO NUMERO
	MOV AH, 9H
	INT 21H
	
	MOV AH, 1H				;LÊ O BYTE COM ECHO
	INT 21H
	
	SUB AL,	48				;TIRA 48 AO VALOR DE AL E GURADA AL EM M1
	MOV M1, AL
	
	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	LEA DX, MSG_ND				;ESCREVE A MSG PARA SER ESCRITO O SEGUNDO NUMERO
	MOV AH, 9H
	INT 21H
	
	MOV AH, 1H 				;LÊ O BYTE COM ECHO
	INT 21H

	SUB AL, 48				;TIRA 48 AO VALOR DE AL	
	MOV M2, AL
	MOV AL, M1	
	
	MOV AH, 0H
	
	DIV M2					;DIVIDE M1 PELO M2, PQ M2 FOI PARA AL
	MOV MR, AL
	
	ADD AH, 48				;PARA OS NUMEROS VOLTAREM A SER NUEMEROS EM TERMOS DECIMAIS
	ADD AL, 48
	ADD M1, 48
	ADD M2, 48
	ADD MR, 48

;-----PARTE DO OUTPUT-----
	
	LEA DX, SPC				;DÁ UM ENTER
	MOV AH, 9H
	INT 21H

	MOV DL, M1				;ESCREVE UM VALOR
	MOV AH, 2H
	INT 21H
	
	LEA DX, MSG_DIV				;ESCREVE "/"
	MOV AH, 9H
	INT 21H
		
	MOV DL, M2				;ESCREVE O OUTRO VALOR
	MOV AH, 2H
	INT 21H

	LEA DX, MSG_EQU				;ESCREVE "="
	MOV AH, 9H
	INT 21H
		
	MOV DL, MR				;ESCREVER O RTESULTADO
	MOV AH, 2H
	INT 21H

	JMP EXIT;				;JUMP PARA "EXIT"

;-----PARTE DO OUTPUT-----

EXIT:
	MOV AH, 4CH				;TERMINA O PROGRMA
 	INT 21H
ENDS
END START
