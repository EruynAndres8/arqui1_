SYS_INIT_MODULE  equ 0x80
SYS_EXIT         equ 0x01
SYS_WRITE        equ 0x04


section	.text
	global _start  ;must be declared for using gcc
	
    int 0x80
	
_start:                     ;tell linker entry point
	mov	edx, len    ;message length
	mov	ecx, msg    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	mov edx, 2
	mov ecx, buf
	mov eax, 3
	mov ebx, 0
	int 0x80
	
	
	;En esta parte empieza la suma
	
	cmp byte [buf], "1"
	
    mov esi, 10
    mov ecx, 20
  
	je mostrar_Suma
	
	;En esta parte empieza la Resta
	
	cmp byte [buf], "2"
	
    mov esi, 50
    mov ecx, 30
  
  
	je mostrar_Resta
	
	;En esta parte empieza la Multiplicación
	
	cmp byte [buf], "3"
  
	je mostrar_Multi
	
	;En esta parte empieza la División
	
	cmp byte [buf], "4"
  
	je mostrar_Div
	
	;En esta parte empieza la Potencia
	
	
	cmp byte [buf], "5"
	
	mov esi, 1
    mov ecx, 4
  
	je mostrar_Pot
	
;Mensaje de Salida por si encuentra el programa una opcion que no es
	
	mov	edx, len_3    ;message length
	mov	ecx, msg_3   ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	

	
	
	
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel


mostrar_Suma: ;SUMA

  add esi, ecx

  mov eax, 1
  mul esi
  aam
  add eax, 3030h
  mov ebp, esp
  sub esp, 2
  mov [esp], byte ah
  mov [esp+1], byte al
  
  mov ecx, esp
  mov eax, SYS_WRITE 
  
  mov edx, 2 ; longitud

  
  mov ebx, 1; mensaje error
  int SYS_INIT_MODULE
  mov esp, ebp


    jmp _start
    
mostrar_Resta: ;RESTA


        sub esi, ecx

        mov eax, 1
        mul esi
        aam
        add eax, 3030h
        mov ebp, esp
        sub esp, 2
        mov [esp], byte ah
        mov [esp+1], byte al
        
        mov ecx, esp
        
        mov eax, SYS_WRITE 
        
        mov edx, 2 ; longitud

        
        mov ebx, 1; mensaje error
        int SYS_INIT_MODULE
        mov esp, ebp
        
        

            
            jmp _start 
    
    
mostrar_Multi: ;MULTIPLICACIÓN

  mov eax, 2
  mov ebx, 40
  
  mul ebx
  
  aam
  add eax, 3030h
  mov ebp, esp
  sub esp, 2
  mov [esp], byte ah
  mov [esp+1], byte al
  mov ecx, esp
  mov edx, 2
  mov ebx, 1
  mov eax, 4
  int 0x80
  
 jmp _start
 
mostrar_Div: ;DIVISIÓN

  mov eax, 18
  mov ebx, 2
  mov edx,0
  div ebx

  
  aad
  
  add eax, 3030h
  mov ebp, esp
  sub esp, 2
  mov [esp], byte ah
  mov [esp+1], byte al
  mov ecx, esp
  mov edx, 2
  mov ebx, 1
  mov eax, 4
  int 0x80
  
  jmp _start 
 
mostrar_Pot: ;POTENCIA

  add esi, esi
  
  dec ecx
  cmp ecx, 0
  jg mostrar_Pot
  mov eax, 1
  mul esi
  
  aam
  add eax, 3030h
  mov ebp, esp
  sub esp, 2
  mov [esp], byte ah
  mov [esp+1], byte al
  mov ecx, esp
  ;mov [var1], ah
  mov eax, SYS_WRITE 
  
  mov edx, 2; longitud
 
  mov ebx, 1; mensaje error
  int SYS_INIT_MODULE
  mov esp, ebp
  
  jmp _start

  
    

section	.data

msg: db 10,13, "Seleccion opcion [1: Suma, 2: Resta, 3: Multiplicación, 4: Division de la Clase , 5: Potencia ]", 0xa
len	equ	$ - msg


msg_3: db 10,13,"Ha Salido del Menu :D", 0xa
len_3 equ $ - msg_3

section .bss
    buf resb 11
    var1: resb 4


