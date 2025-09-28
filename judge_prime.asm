.386
.model flat, c
option casemap:none

extern getrand: proc, fast_pow: proc

.code
public judge_prime
judge_prime PROC
    push    ebp
    mov     ebp, esp
    sub     esp, 4
    mov     eax, [ebp + 8]
    cmp     eax, 1
    je      not_prime
    cmp     eax, 3
    jle      is_prime
    mov     ecx, 100 ; test for 100 times
loop_start:
    push    eax
    push    ecx

    mov     ebx, eax
    sub     ebx, 2
    push    ebx
    push    2
    ; range frome 2 to n - 2, then get a random num
    call    getrand
    mov     esi, eax
    add     esp, 8
    
    mov     ecx, [esp]
    mov     eax, [esp + 4]

    ; clear the stack
    push    eax
    dec     eax
    push    eax
    push    esi
    call    fast_pow
    ; get rand ^ (n - 1) mod n
    add     esp, 12
    ; clear the stack
    mov     edx, eax
    pop     ecx
    pop     eax
    cmp     edx, 1
    jne     not_prime
    loop	loop_start
is_prime:
    mov     eax, 1
    jmp     end_judge
not_prime:
    mov     eax, 0
end_judge:
    add	    esp, 4
    pop     ebp
    ret
judge_prime ENDP
END