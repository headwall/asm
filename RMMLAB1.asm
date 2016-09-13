stack segment para ‘stack’
	db 100h dup(?)
stack ends

data segment para public ‘data’
    arr dw -2,-1,-10,4,5,6,-13,8,9,10,25,2,-11,15,-6
    res dw 10 dup(0)
    amount_non_sort dw 15
    sorted_bound dw 0
    min_id dw 0
    temp dw
data ends

code segment para public ‘code’
    assume cs:code, ds:data, ss:stack

start:
    ;array pointer = 0
    xor si,si
    ;ax = 0
    xor ax,ax
    ;save the array's pointer i n var "sorted_bound"
    ;which save the array's sorted part bound
    mov sorted_bound, si
    ;"si" is the array's non sorted part pointer
    add si,2
    ;"cx" is loop counter for the array's non sorted part 
    ;from "sorted_bound" to the array's last element
    mov cx,amount_non_sort
    find_min:
        ;negative?
    	cmp arr[si],0
        ;no - next iteration
    	jge find_min_end
        ;yes - min?
    	cmp arr[si],arr[min_id]
        ;no - next iteration
    	jge find_min_end
        ;yes - save index of min element 
        mov min_id,si
        add si,2
    find_min_end: loop find_min
    ;swap min & bound elements 
    swap_elements:
        mov temp,arr[sorted_bound]
        mov arr[sorted_bound],arr[min_id]
        mov arr[min_id],temp
    ;amount of arrays non sort elements - 1      
    dec amount_non_sort
    ;mov arrays sorted part bound 
    add sorted_bound,2
    ;whole array sorted? 
    mov cx,amount_non_sort
    cmp cx,0 
    ;no - find min again
    jg find_min

code ends
  end start
