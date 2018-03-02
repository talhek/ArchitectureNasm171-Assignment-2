section	.rodata
LC0:
	DB	"%s", 10, 0	; Format string

section .bss
LC1:
	RESB	256

section .text
	align 16
	global my_func
	extern printf

my_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	pushad			; Save registers

	mov ecx, dword [ebp+8]	; Get argument (pointer to string)

		mov edx, LC1

		start:
			cmp byte[ecx], 10
			je end

			sub byte[ecx], '0'
			mov bl, byte[ecx]
			mov al, 16
			mul bl

			inc ecx

			cmp byte[ecx], 'A'
			jl changeNum

			cmp byte[ecx], 'a'
			jnb change1

			sub byte[ecx], 'A'
			add byte[ecx], 10	
			jmp continue

		changeNum:
			sub byte[ecx], '0'			
			jmp continue
		
		change1:
			sub byte[ecx], 'a'
			add byte[ecx], 10
			jmp continue

		continue:
			add al, byte[ecx]
			mov byte[edx], al
			inc edx	
			inc ecx  
			cmp byte [ecx], 0         ; check if byte pointed to is zero
			jnz start		          ; keep looping until it is null terminated

		end:


	push	LC1		; Call printf with 2 arguments: pointer to str
	push	LC0		; and pointer to format string.
	call	printf
	add 	esp, 8		; Clean up stack after call

	popad			; Restore registers
	mov	esp, ebp	; Function exit code
	pop	ebp
	ret

