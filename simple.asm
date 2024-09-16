%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    for:
        mov bl, byte [esi]      ; am retinut fiecare caracter din sir in bl
        inc esi                 ; am incrementat registrul pentru a trece la urmatorul caracter
        sub bl, 'A'             ; am scazut valoarea ASCII a lui 'A' din registru
        add bl, dl              ; am adaugat valoarea pasului
        cmp bl, 26              ; am comparat valoarea obtinuta cu 26, pt a verifica daca se
        jl continuare           ; trece de valoarea lui 'Z'
        sub bl, 26              ; daca s-a trecut, am scazut 26 din registru
    
    continuare:
        add bl, 'A'             ; am transformat bl in caracter
        mov byte [edi], bl      ; am memorat valoarea lui in noul sir
        inc edi                 ; am trecut la caracterul urmator din sir
        dec ecx                 ; am scazut din lungimea sirului
        cmp ecx, 0              ; bucla continua pana ce se ajunge la finalul sirului
        jne for                
    
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
