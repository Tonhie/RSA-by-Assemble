.386
.model flat, c
option casemap:none

extern gcd: proc, ext_gcd: proc, generate_prime: proc

.code
public generate_key
generate_key PROC
    LOCAL   r: dword, l: dword
    push    ebp
    mov     ebp, esp
    sub     esp, 8
generate_two_prime:
    push    0FFFFH
    push    08000H
    call	generate_prime      ; generate prime from 8000H to FFFFH
    add     esp, 8
    push    eax
    push    0FFFFH
    push    08000H
    call	generate_prime
    add     esp, 8
    pop     ecx
    ; now eax = q, ecx = p
    cmp     eax, ecx
    je      generate_two_prime ; ensure p != q

    mov     ebx, eax
    mul     ecx
    mov     edx, eax
    mov     eax, ebx
    mov	    ebx, edx
    dec     eax
    dec     ecx
    mul     ecx
    mov     ecx, ebx
    ; now ecx = p * q, eax = (p - 1) * (q - 1)

    mov     edx, [ebp + 28]
    mov     [edx], ecx          ; store public_modulus

    mov     ebx, 0101H          ; choose e = 257
    mov     edx, [ebp + 24]
    mov     [edx], ebx

    lea     edx, r
    push    edx
    lea     edx, l
    push    edx
    mov     esi, [ebp + 20]      ; push private_key
    push	esi
    push    eax                 ; push (p - 1) * (q - 1)
    push    ebx                 ; push e
    call	ext_gcd
    add     esp, 20

    add	    esp, 8              ; Clean up local variables
    pop	    ebp
    ret
    ; private_key: esi, public_key: edi, public_modulus: ebx
generate_key ENDP
END