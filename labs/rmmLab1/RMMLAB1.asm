stack segment para 'stack'
	db 100h dup(?)
stack ends

data segment para public 'data'
    arr dw -2,-1,-10,4,5,6,-13,8,9,10,25,2,-11,15
    res dw 14 dup(0)
    amount_non_sort dw 14
    sorted_bound dw 0
    min_id dw 0
    l_val dw 0
    r_val dw 0
data ends

code segment para public 'code'
    assume cs:code, ds:data, ss:stack

start:
    mov ax,DATA
    mov ds,ax
	; -----------
	; TASK 1
	; -----------

    ; array pointer = 0
    xor si,si
    ; ax = 0
    xor ax,ax
    ; save the array's pointer i n var "sorted_bound"
    ; which save the array's sorted part bound
    mov sorted_bound, si
    ; "si" is the array's non sorted part pointer
    add si,2
    ; "cx" is loop counter for the array's non sorted part 
    ; from "sorted_bound" to the array's last element
    mov cx,amount_non_sort
    find_min:
        ; negative?

	cmp arr[si],0
        ; no - next iteration
    	jge find_min_end
        ; yes - min?
	mov ax,arr[si]
	mov di,min_id
	cmp ax,arr[di]
        ; no - next iteration
    	jge find_min_end
        ; yes - save index of min element 
	mov min_id,si
    find_min_end:
	add si,2
	dec cx
	cmp cx,0
	jg find_min
    ; swap min & bound elements 
    swap_elements:
	mov di,sorted_bound
	mov dx,arr[di]
	mov bx,min_id
	mov ax,arr[bx]
	mov arr[di],ax
	mov arr[bx],dx
    ; amount of arrays non sort elements - 1      
    dec amount_non_sort
    ; mov arrays sorted part bound 
    add sorted_bound,2
    mov si,sorted_bound
    mov min_id,si
    ; whole array sorted? 
    mov cx,amount_non_sort
    cmp cx,0 
    ; no - find min again
    jg find_min

	; -----------
	; TASK 2
	; -----------

	; define range of result array's elements value
	mov dx,arr[2]
	neg dx
	mov ax,arr[24]
	neg ax
	cmp ax,dx

	jge r_val_greater
	jmp l_val_greater
	l_val_greater:
		mov l_val,ax
		mov r_val,dx
		jmp make_res
	r_val_greater:
		mov l_val,dx
		mov r_val,ax
	
	;make result array
	make_res:
	add cx,14
	xor si,si
	xor di,di
	make_res_loop:
		; condition for checking origin array's element
		mov ax,arr[si]
		; left range bound checking
		cmp ax,l_val
		jge r_range_checking
		jmp make_res_loop_end
		
		r_range_checking:
			cmp r_val,ax
			jge move_to_result
			jmp make_res_loop_end
		move_to_result:
			mov res[di],ax
			add di,2

	make_res_loop_end:
		add si,2
		dec cx
		cmp cx,0
		jg make_res_loop

     mov ax,4C00H
    int 21H
code ends
  end start
