%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    xor ecx, ecx            ; am initializat registul ecx cu zero
    dec eax                 ; voi itera pana la n-1, asa ca am decrementat lungimea
    mov ebx, eax            ; am salvat lungimea proceselor în ebx
    xor edi, edi            ; am initializat registul edi cu 0

multiplication:             ; am calculat dimensiunea vectorului, in functie de structura
    cmp ecx, ebx            ; am folosit un loop pentru a calcula 5*dimensiunea_initiala 
    je finished             ; deoarece structura contine 2 elemente de dimensiune 2bytes
    add edi, 5              ; si 1 element de 1byte
    inc ecx                 ; am retinut dimensiunea in registrul edi
    jmp multiplication

finished:                   ; am initializat ebx cu 1, pentru ca vectorul nu e sortat
    mov ebx, 1              ; acesta va deveni apoi 0, urmand sa devina 1 daca are loc un schimb

whileloop:
    xor ecx, ecx            ; ecx este contorul, la care voi aduna 5, trecand de la
    cmp ebx, 0              ; element la element pana ce se va atinge dimensiunea finala
    je sorted
    xor ebx, ebx
    jmp sortloop

sortloop:
    cmp ecx, edi    ; verific daca am ajuns la finalul vectorului
    je whileloop
    mov al, byte[edx + ecx + proc.prio]         ; am mutat prioritatile proceselor in 
    mov ah, byte[edx + ecx + 5 + proc.prio]     ; registre de 8biti
    cmp al, ah      ; daca prioritatea primului este mai mare atunci se face schimbul
    jg swp
    add ecx, 5      ; daca ordinea este corecta, am adaugat 5 la ecx pentru a semnala
    cmp al, ah      ; ca s-a trecut la pozitia urmatoare din vector
    jl sortloop 
    sub ecx, 5      ; am scazut 5, pt a ma reintoarce la pozitia initiala
    mov ax, word [edx + ecx + proc.time]        ; am mutat timpul proceselor
    mov si, word [edx + ecx + 5 + proc.time]    ; in registre de 16biti
    cmp ax, si      ; daca timpul primului este mai mare atunci se face schimbul
    jg swp
    add ecx, 5      ; daca ordinea este corecta, se procedeaza ca in cazul prioritatii
    cmp ax, si
    jl sortloop
    sub ecx, 5
    mov eax, ebx    ; am retinut in eax valoarea lui ebx
    mov bx, word [edx + ecx + proc.pid]         ; am mutat id-ul proceselor
    mov si, word [edx + ecx + 5 + proc.pid]     ; in registre de 16biti
    cmp bx, si      ; daca id-ul primului este mai mare atunci se face schimbul
    jg swp
    mov ebx, eax    ; altfel, ebx isi reia valoarea initiala
    add ecx, 5      ; se trece la elementele urmatoare
    jmp sortloop

swp:
    ; am retinut prioritatile in registrii de 8 biti si am facut schimbul
    mov al, byte [edx + ecx + proc.prio]
    mov ah, byte [edx + ecx + 5 + proc.prio]
    xchg al, ah
    ; am adaugat apoi valorile actualizate in vector
    mov [edx + ecx + proc.prio], al
    mov [edx + ecx + 5 + proc.prio], ah
    ; am retinut id-urile in registrii de 16 biti si am facut schimbul
    mov ax, word [edx + ecx + proc.pid]
    mov si, word [edx + ecx + 5 + proc.pid]
    xchg ax, si
    ; am adaugat apoi valorile actualizate in vector
    mov [edx + ecx + proc.pid], ax
    mov [edx + ecx + 5 + proc.pid], si
    ; am retinut timpul in registrii de 16 biti si am facut schimbul
    mov bx, word [edx + ecx + proc.time]
    mov si, word [edx + ecx + 5 + proc.time]
    xchg bx, si
    ; am adaugat apoi valorile actualizate in vector
    mov [edx + ecx + proc.time], bx
    mov [edx + ecx + 5 + proc.time], si
    mov ebx, 1      ; a avut loc o schimbare, deci ebx devine 1
    add ecx, 5      ; am trecut la elementul urmator
    jmp sortloop

sorted:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY