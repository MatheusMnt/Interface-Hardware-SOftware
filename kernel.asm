; comentarios

;TODO o resultado está x3
ORG 0x7C00
BITS 16
    jmp start

msg: db "a", 0x0D, 0x0A, 0

start:

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov si, msg
    mov cx, 0
    call count_vogal

end:
    jmp $ ; halt


print_string:
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp .loop
.done:
    ret

print_number:
    mov bx, 10
    mov ax, cx ;; copia o valor de cx para Ax
    mov cx, 0
.loop1:
    mov dx, 0
    div bx
    ; resposta vai ta no ax, resto no dx
    add dx, 48
    push dx
    inc cx
    cmp ax, 0
    jne .loop1
.loop2:
    pop ax
    mov ah, 0x0E
    int 0x10
    loop .loop2
.done:
    ret
 
count_vogal:
    lodsb
    cmp al, 'a'
    je count
    cmp al, 'A'
    je count
    cmp al, 'e'
    je count
    cmp al, 'E'
    je count
    cmp al, 'i'
    je count
    cmp al, 'I'
    je count
    cmp al, 'o'
    je count
    cmp al, 'O'
    je count
    cmp al, 'u'
    je count
    cmp al, 'U'
    je count
    cmp al, 0
    je print_number
    

count:
   inc cx
   call count_vogal
 

 
; assinatura de boot

    times 510-($-$$) db 0
    dw 0xAA55
