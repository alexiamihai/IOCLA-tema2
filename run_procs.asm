%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs
    extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor eax, eax
    mov edx, ebx
    xor ebx, ebx

multiplication:         ; am calculat in ebx 5*lungimea_initiala
    cmp eax, edx        ; pentru a ma raporta la dimensiunea structurii
    je finished
    add ebx, 5
    inc eax
    jmp multiplication

finished:
    xor eax, eax        ; am initializat eax si edx cu 0
    xor edx, edx        ; eax va lua valoarea celor 5 indici de prioritate
results:
    cmp eax, 5          ; daca am ajuns la prioritatea 6, creez vectorul
    je create           ; pt ca suma si nr de procese au fost calculate
    inc eax             ; pentru toate prioritatile
    jmp prioritate

prioritate:
    cmp edx, ebx        ; verific daca am ajuns la finalul vecctorului
    je create
    movzx edi, byte[ecx + edx + proc.prio]      ; am retinut in edi si esi
    movzx esi, byte[ecx + edx + proc.time]      ; prioritatea si timpul
    cmp edi, eax        ; daca prioritatea nu e egala cu cea retinuta in eax inseamna ca
    jne results         ; s-a trecut la o noua prioritate deci il pot incrementa pe eax
    dec eax             
    add [time_result + 4 * eax], esi    ; am adaugat timpul la suma
    add dword[prio_result + 4 * eax], 1     ; am crescut numarul de procese cu acea prioritate
    inc eax
    add edx, 5
    jmp prioritate

create:
    xor ecx, ecx            ; am initializat ecx cu 0
    mov eax, [ebp + 16]     ; am mutat in eax adresa vectorului avg
    
vector:
    push eax    ; intrucat am nevoie de eax pentru impartire, am salvat valoarea lui pe stiva
    cmp ecx, 20     ; am verificat daca s-au completat toate cele 5 elemente ale vectorului
    je avgready
    mov eax, dword [time_result + ecx]      ; in eax am salvat deimpartitul
    mov ebx, dword [prio_result + ecx]      ; in ebx am salvat impartitoul
    cmp ebx, 0      ; daca impartitorul este 0, atunci nu se poate efectua impartirea
    je zero
    xor edx, edx    ; am initializat edx cu 0  
    div ebx         ; l-am impartit pe eax la ebx, catul fiind salvat în eax, iar restul în edx
    mov ebx, eax    ; am salvat catul in ebx
    pop eax         ; am recuperat valoarea lui eax de pe stiva
    mov  [eax + ecx + avg.quo], bx     ; am salvat valorile obtinute in structura
    mov  [eax + ecx + avg.remain], dx
    add ecx, 4      ; am trecut la urmatorul element
    jmp vector

zero:
    ; atat restul, cat si catul vor fi 0
    pop eax
    mov word [eax + ecx * 4 + avg.quo], 0
    mov word [eax + ecx * 4 + avg.remain], 0 
    add ecx, 4
    jmp vector

avgready: 
    pop eax
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY