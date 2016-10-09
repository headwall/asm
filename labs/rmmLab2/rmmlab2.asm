stack segment para STACK 'stack'
	db 100 dup(?)
stack ends

data segment para 'data'
	originString db "56piO, qwerty9:  Y84;?IP:AsxSH! g6N.,?Kd  !;MaPySa112710 : lo sh"
	db "-"
	res1 db 64 dup(0)
	db "-"
	res2 db 64 dup(0)
	db "-"
	resCondition db 8 dup("F")
	;1010110101010001010101010100100100101000011001010101111110101111
	db "-"
	resConditionL dd 0
	db "-"
	resConditionR dd 0
	db "-"
	DIGITS db "0123456789"
	COMMA db ","
	SMALL_LETTERS db "abcdefghijklmnoprstuvwxyz"
	db "-"
	origin_cx dw 64
	db "-"
	temp_cx dw 64
data ends
	
code segment para 'code'
	assume cs:code, ds:data, ss:stack
	.386
start:
	mov ax, data
	mov ds, ax

	;-------Var 24-------
	;-------z.4/2--------

	;--------------------
	;-------Task 1-------
	;--------------------

	; making first state of machine
	xor eax, eax
	xor si, si
	xor di, di
	xor dx, dx
	mov cx, origin_cx
	cld 
	clc
	;loading of condition bytes string
	lea si, resCondition
	lodsd resConditionL
	add si, 4
	lodsd resConditionR
	xor eax, eax
	xor si, si

	main_loop:
		;take first bit of resCondition
		mov eax, resConditionR
		shl eax, 1
		mov resConditionR, eax
		mov eax, resConditionL 
		shl eax, 1
		mov resConditionL, eax
		;if 1 handle simbol of originString
		jc handle_digit_simbol
		;if 0 check for second string
		mov al, originString[si]
		cmp al, COMMA
		je handle_lowercase_simbol


	handle_lowercase_simbol:
		mov bl, originString[si+1]
		xor di, di
		next_lowercase_simbol:
			cmp bl, SMALL_LETTERS[di]
			inc di
			cmp di, 25
			jne next_lowercase_simbol
			mov res2[si], al
			jmp main_loop_end
	stop_making_res2:
		; stop making res2
		mov dx, 1
		jmp main_loop_end

	handle_digit_simbol:
		xor di, di
		next_digit_simbol:
			mov al, originString[si]
			cmp al, DIGITS[di]
			jne add_to_res1
			inc di
			cmp di, 10
			je main_loop_end
			jmp next_digit_simbol
	add_to_res1:
		mov res2[si], al
		jmp main_loop_end 		

	main_loop_end:
		dec cx
		cmp cx, 0
		jne main_loop

	mov ax, 4C00H
	int 21h

code ends
	end start
