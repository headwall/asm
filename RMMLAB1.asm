stack segment para ‘stack’
	db 100h dup(?)
stack ends

data segment para public ‘data’
    arr dw -2,-1,-10,4,5,6,-13,8,9,10,25,2,-11,15,-6
    res dw 10 dup(0)
    amount_non_sort dw 15
    sorted_bound dw
    min_id dw
data ends

code segment para public ‘code’
    assume cs:code, ds:data, ss:stack

start:
    ;array pointer = 0
    xor si,si
    ;ax = 0
    xor ax,ax
    ;save the array's pointer in var "sorted_bound"
    ;which save the array's sorted part bound
    mov sorted_bound, si
    ;"si" is the array's non sorted part pointer
    add si,2
    ;"cx" is loop counter for the array's non sorted part 
    ;from "sorted_bound" to the array's last element
    mov cx,amount_non_sort
    find_min:
    	cmp arr[si],0
    	jge find_min_end
    	cmp arr[si],arr[min]
    	jge find_min_end

    find_min_end: loop find_min


code ends
  end start
