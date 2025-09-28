.386
.model flat, c
option casemap:none

extern getrand: proc, judge_prime: proc

.code
public generate_prime
generate_prime PROC
    push    ebp
    mov     ebp, esp

    mov     esi, [ebp + 8]
    mov     edi, [ebp + 12]

    push    edi
    push    esi
    call    getrand
    add	    esp, 8

    mov     esi, eax
    mov     ecx, esi
    ; max: edi, org: esi
right_loop:
    cmp     ecx, edi
    jg	    reach_max
    push    ecx
    push    esi
    push    edi

    push    ecx
    call    judge_prime
    add     esp, 4

    pop     edi
    pop     esi
    pop     ecx
    cmp     eax, 1
    je      found_prime
    inc     ecx
    jmp     right_loop
reach_max:
    mov     edi, [ebp + 8]
    dec     esi
    mov     ecx, esi
    ; min: edi, org: esi
left_loop:
    cmp     ecx, edi
    jl      not_exist ; reach min
    push    ecx
    push    esi
    push    edi

    push    ecx
    call    judge_prime
    add     esp, 4
    
    pop     edi
    pop     esi
    pop     ecx
    cmp     eax, 1
    je      found_prime
    dec     ecx
    jmp     left_loop
not_exist:
    mov     eax, 0
    jmp     end_generate
found_prime:
    mov     eax, ecx
end_generate:
    pop     ebp
    ret
generate_prime ENDP
END