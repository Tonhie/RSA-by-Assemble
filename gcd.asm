.386
.model flat, c
option casemap:none
.code
public gcd
gcd PROC
    LOCAL   aa: dword, bb: dword, rr: dword
    push    ebp
    mov     ebp, esp
    pusha
    mov     eax, [ebp + 24]  ; Load first argument (aa)
    mov     aa, eax
    mov     eax, [ebp + 28] ; Load second argument (bb)
    mov     bb, eax
LOOP_ECULID:
    mov     eax, aa
    xor     edx, edx
    div     bb
    cmp	    edx, 0
    je	    END_ECULID
    mov     rr, edx
    mov     eax, bb
    mov     aa, eax
    mov     eax, rr
    mov     bb, eax
    jmp	    LOOP_ECULID
END_ECULID:
    mov     eax, bb
    mov     ebx, [ebp + 32]
    mov     [ebx], eax
    popa
    pop     ebp
    ret
gcd ENDP
END