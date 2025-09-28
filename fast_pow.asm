.386
.model flat, c
option casemap:none
.code
public fast_pow
fast_pow PROC
    push    ebp
    mov     ebp, esp
    ; x = [ebp + 8], m = [ebp + 12], n = [ebp + 16]
    ; esi: m, edi: ans, ebx: base, ecx : n
    mov     esi, [ebp + 12]
    mov	    edi, 1
    mov     eax, [ebp + 8]
    mov     ecx, [ebp + 16]
    xor     edx, edx
    div     ecx
    mov     ebx, edx
POW_LOOP:
    test    esi, 1
    jz      SQUARE
    mov     eax, edi
    xor     edx, edx
    mul     ebx
    div     ecx
    mov     edi, edx
SQUARE:
    mov     eax, ebx
    xor     edx, edx
    mul	    ebx
    div     ecx
    mov     ebx, edx
    shr     esi, 1
    jz      POW_END
    jmp     POW_LOOP
POW_END:
    mov     ebx, [ebp + 20]
    mov     eax, edi
    pop     ebp
    ret
fast_pow ENDP
END