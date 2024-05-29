section .data
    hello db 'Hello, World!', 0

section .text
    global _start

_start:
    ; ...

    ; Read the loop count from the terminal
    mov eax, 3
    mov ebx, 0
    mov ecx, input_buffer
    mov edx, 10
    int 0x80

    ; Convert the input to a number
    mov esi, input_buffer
    xor eax, eax
    mov ebx, 10
convert_loop:
    lodsb
    cmp al, 0x0A ; Check for newline character
    je convert_done
    sub al, 0x30 ; Convert ASCII digit to number
    mul ebx
    add eax, ebx
    jmp convert_loop
convert_done:
    mov ecx, eax ; Store the loop count in ecx

    ; Loop the specified number of times
loop_start:
    ; Print "Hello, World!"
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, 13
    int 0x80

    ; Decrement the loop counter
    dec ecx

    ; Check if the loop counter is zero
    jnz loop_start

    ; ...

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .bss
    input_buffer resb 10