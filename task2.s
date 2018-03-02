section .data                    	; data section, read-write
   anCalc:		DD 0
   tmp:			DD 0
   answer:              DD 0

section	.rodata
	finalAn:
		DB	"%d", 10, 0
        notLegal:
                DB      "x or k, or both are off range", 29, 0     

section .text
	global calc_div
	extern check
	extern printf
		

calc_div:

	push ebp
	mov ebp, esp
	
	pushad
	mov ebx, dword[ebp+12]			; this is k - IN BL
	mov ecx, dword[ebp+8]			; this is x - IN CL

	push ebx                                ;push argument #2
	push ecx                                ;push argument #1
	call check                              ;call the function
        mov [answer], eax                       ;retrive the return value from eax
        add esp, 8                              ;"delete" function arguments
        
        cmp dword[answer], 1                    ;checks if input is legal
        jne endLegal                            ;in case input isn't legal, ends the program
	mov dword[tmp], ecx		       		; now x is in tmp
	mov ecx, ebx					; now k is in ecx
	
	my_loop:
		shr dword[tmp], 1
		loop my_loop, ecx


        
	push dword[tmp];						; call printf with two arguments
	push finalAn
	jmp continue
	
endLegal:                   ;displaying a msg that input isn't legal and ends the program
        push notLegal
        jmp continue
        
continue:
	call printf
	add esp, 8
	popad
	mov esp, ebp					; move ebp to esp
	pop ebp							; restore old ebp
	ret 							; return from the function