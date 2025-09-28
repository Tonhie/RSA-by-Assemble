.386
.model flat, c
option casemap:none
extern fast_pow: proc
.code
public decrypt
decrypt PROC
    push    ebp
    mov     ebp, esp
    
    
    mov     esi, [ebp + 16]  ; load chipertext
    mov     edi, [ebp + 20]  ; load plaintext

decrypt_loop:
    mov     ecx, 4
    mov     eax, 0
    mov     edx, 0
    add     esi, 4
sub_loop:
    dec     esi
    mov     dl, byte ptr [esi]
    movzx   edx, dl
    shl     eax, 8
    add     eax, edx
    loop    sub_loop
    ; convert every 4 byte

    cmp     eax, 0
    jz      end_decrypt ; if eax is 0, end of the ciphertext

    add     esi, 4

    push    esi
    push    edi

    mov     ebx, [ebp + 12]  ; load public modolus
    push    ebx		         ; public modulus
    mov     ebx, [ebp + 8]   ; load private key
    push    ebx		         ; private key
    push    eax    	         ; chipertext
    call    fast_pow
    add     esp, 12

    pop     edi
    pop     esi

    mov     [edi], eax
    add     edi, 3

    jmp     decrypt_loop
end_decrypt:
    mov     al, 0
    mov     [edi], al         ; end of the ciphertext
    pop     ebp
    ret
decrypt ENDP
END