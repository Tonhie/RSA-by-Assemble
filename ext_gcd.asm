.386
.model flat, c
option casemap:none
.code
public ext_gcd
ext_gcd PROC
    LOCAL   aa: dword, bb: dword, rr: dword, q: dword, 
            ka: dword, kb: dword, la: dword, lb: dword
    push    ebp
    mov     ebp, esp
    pusha
    mov     ka, 1
    mov     kb, 0
    mov     la, 0
    mov     lb, -1
    mov     eax, [ebp + 44]
    mov     aa, eax
    mov     eax, [ebp + 48]
    mov     bb, eax
    ; Initialize aa, bb, ka, kb, la, lb
LOOP_ECULID:
    mov     eax, aa
    xor     edx, edx
    div     bb
    cmp	    edx, 0
    je	    END_ECULID
    mov     q, eax
    mov     rr, edx
    ;aa / bb = q ... rr, exit if rr == 0
    imul    kb
    mov     ebx, eax
    mov     eax, ka
    sub     eax, ebx
    mov     ebx, kb
    mov     ka, ebx
    mov     kb, eax
    ; Update ka and kb
    mov     eax, q
    imul    lb
    mov     ebx, eax
    mov     eax, la
    sub     eax, ebx
    mov     ebx, lb
    mov     la, ebx
    mov     lb, eax
    ; Update la and lb
    mov     eax, bb
    mov     aa, eax
    mov     eax, rr
    mov     bb, eax
    ; Update aa and bb
    jmp	    LOOP_ECULID
END_ECULID:
    cmp     kb, 0
    jge	    END_POSITIVE
    mov     eax, [ebp + 44]
    add     lb, eax
    mov     eax, [ebp + 48]
    add     kb, eax
    ; ensure lb and kb are positive
END_POSITIVE:
    mov     eax, kb
    mov     ebx, [ebp + 52]
    mov     [ebx], eax
    mov     eax, lb
    mov     ebx, [ebp + 56]
    mov     [ebx], eax
    mov     eax, bb
    mov     ebx, [ebp + 60]
    mov     [ebx], eax
    ; Pass values
    popa
    pop     ebp
    ret
ext_gcd ENDP
END