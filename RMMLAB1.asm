stack segment para ‘stack’
	db 100h dup(?)
stack ends

data segment para public ‘data’
    mas dw -2,-1,-10,4,5,6,-13,8,9,10,25,2,-11,15,-6
    res dw 
data ends

code segment para public ‘code’
    assume cs: code, ds: data, ss: stack

start:
    xor si,si
    xor ax,ax
    mov cx, 15
    external_loop: 
     mov dx,si
     internal_loop:
     	
    loop external_loop

code ends
  end start
