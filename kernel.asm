; comentarios


ORG 0x7C00
BITS 16
    jmp start

msg: db "Centro de informatica", 0x0D, 0x0A, 0

start:

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov si, msg
    mov ax, 0
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
    dec cx ;ele conta uma interação a mais 
    mov ax, cx
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
 
get_vogal:
    lodsb
    cmp al, 'a'
    je count_vogal
    cmp al, 'A'
    je count_vogal
    cmp al, 'e'
    je count_vogal
    cmp al, 'E'
    je count_vogal
    cmp al, 'i'
    je count_vogal
    cmp al, 'I'
    je count_vogal
    cmp al, 'o'
    je count_vogal
    cmp al, 'O'
    je count_vogal
    cmp al, 'u'
    je count_vogal
    cmp al, 'U'
    je count_vogal
    cmp al, 0
    je print_number
    jmp get_vogal

count_vogal:
   inc cx
   call get_vogal 

; assinatura de boot

    times 510-($-$$) db 0
    dw 0xAA55
