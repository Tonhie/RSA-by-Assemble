.386
.model flat, c
option casemap:none
extern fast_pow: proc
.code
public encrypt
encrypt PROC
    push    ebp
    mov     ebp, esp
    
    
    mov     esi, [ebp + 16]  ; load plaintext
    mov     edi, [ebp + 20]  ; load chipertext

encrypt_loop:
    mov     ecx, 3
    mov     eax, 0
    mov     edx, 0
    add     esi, 3
sub_loop:
    dec     esi
    mov     dl, byte ptr [esi]
    cmp     dl, 0
    jnz     continue_loop
    cmp     ecx, 1
    je      end_encrypt
    mov     eax, 0
continue_loop:
    movzx   edx, dl
    shl     eax, 8
    add     eax, edx
    loop    sub_loop
    add     esi, 3
    ; convert every 3 byte

    push    esi
    push    edi

    mov     ebx, [ebp + 12]  ; load public modolus
    push    ebx		         ; public modulus
    mov     ebx, [ebp + 8]   ; load public key
    push    ebx		         ; public key
    push    eax    	         ; plaintext
    call    fast_pow
    add     esp, 12

    pop     edi
    pop     esi

    mov     [edi], eax
    add     edi, 4

    jmp     encrypt_loop
end_encrypt:
    mov     eax, 0
    mov     [edi], eax         ; end of the ciphertext
    pop     ebp
    ret
encrypt ENDP
END