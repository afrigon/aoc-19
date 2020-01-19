section .text
bits 64

global _start
_start:
	xor r14, r14

loop:
	mov rax, [program+r14*8]
	inc r14

	cmp rax, 2
	je mul
	jb add
	ja exit_success

	jmp exit_failure

add:
	mov rax, [program+(r14)*8]
	mov rbx, [program+(r14+1)*8]
	add rax, rbx
	mov [program+(r14+2)*8], rax
	jmp loop

mul:
	mov rax, [program+(r14)*8]
	mov rbx, [program+(r14+1)*8]
	mul ebx
	mov [program+(r14+2)*8], rax
	jmp loop

exit_success:
	mov rax, [program]
	call int2ascii

	mov [output], rdi
	mov rdi, output
	call print
	
	jmp exit

exit_failure:
	jmp exit

exit:
	mov rdi, 0
	mov rax, 60
	syscall

; from https://codereview.stackexchange.com/questions/142842/integer-to-ascii-algorithm-x86-assembly
int2ascii:
    mov ebx, 0xCCCCCCCD             
    xor rdi, rdi

.loop:
    mov ecx, eax                    ; save original number

    mul ebx                         ; divide by 10 using agner fog's 'magic number'
    shr edx, 3                      ;

    mov eax, edx                    ; store quotient for next loop

    lea edx, [edx*4 + edx]          ; multiply by 10
    shl rdi, 8                      ; make room for byte
    lea edx, [edx*2 - '0']          ; finish *10 and convert to ascii
    sub ecx, edx                    ; subtract from original number to get remainder

    lea rdi, [rdi + rcx]            ; store next byte

    test eax, eax
    jnz .loop 
	ret

print:
	xor rdx, rdx
.loop:
	mov bl, [rsi+rdx]
	test bl, bl
	jz print.end

	inc rdx
	jmp print.loop
.end:
	mov rax, 1
	mov rdi, 1
	syscall
	ret

section .data

str_error: db "hello",0xa,0
output: dq 0

program:
	dq 1
	dq 12
	dq 2
	dq 3
	dq 1
	dq 1
	dq 2
	dq 3
	dq 1
	dq 3
	dq 4
	dq 3
	dq 1
	dq 5
	dq 0
	dq 3
	dq 2
	dq 1
	dq 13
	dq 19
	dq 2
	dq 9
	dq 19
	dq 23
	dq 1
	dq 23
	dq 6
	dq 27
	dq 1
	dq 13
	dq 27
	dq 31
	dq 1
	dq 31
	dq 10
	dq 35
	dq 1
	dq 9
	dq 35
	dq 39
	dq 1
	dq 39
	dq 9
	dq 43
	dq 2
	dq 6
	dq 43
	dq 47
	dq 1
	dq 47
	dq 5
	dq 51
	dq 2
	dq 10
	dq 51
	dq 55
	dq 1
	dq 6
	dq 55
	dq 59
	dq 2
	dq 13
	dq 59
	dq 63
	dq 2
	dq 13
	dq 63
	dq 67
	dq 1
	dq 6
	dq 67
	dq 71
	dq 1
	dq 71
	dq 5
	dq 75
	dq 2
	dq 75
	dq 6
	dq 79
	dq 1
	dq 5
	dq 79
	dq 83
	dq 1
	dq 83
	dq 6
	dq 87
	dq 2
	dq 10
	dq 87
	dq 91
	dq 1
	dq 9
	dq 91
	dq 95
	dq 1
	dq 6
	dq 95
	dq 99
	dq 1
	dq 99
	dq 6
	dq 103
	dq 2
	dq 103
	dq 9
	dq 107
	dq 2
	dq 107
	dq 10
	dq 111
	dq 1
	dq 5
	dq 111
	dq 115
	dq 1
	dq 115
	dq 6
	dq 119
	dq 2
	dq 6
	dq 119
	dq 123
	dq 1
	dq 10
	dq 123
	dq 127
	dq 1
	dq 127
	dq 5
	dq 131
	dq 1
	dq 131
	dq 2
	dq 135
	dq 1
	dq 135
	dq 5
	dq 0
	dq 99
	dq 2
	dq 0
	dq 14
	dq 0

