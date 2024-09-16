%include "../include/io.mac"
section .data

section .text
    global bonus
    extern printf

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; am calculat numarul de ordine al fiecarei casute pe care poate fi plasata o piesa in edx
    mov edx, eax
    imul edx, 8
    add edx, ebx

; in functie de pozitia piesei, am determinat in care dintre cele 2 jumatati ale tablei se afla
jumatati:
    cmp edx, 31
    jg sus
    jmp jos

sus:
    ; am scazut 32 din edx pentru a obtine pozitia actuala din matricea impartita in doua
    sub edx, 32
    ; cazul in care ne aflam pe prima linie a jumatatii de sus a matricei
    cmp edx, 8
    jl susprimalinie
    ; cazul in care ne aflam pe ultima linie a jumatatii de sus a matricei
    cmp edx, 23
    jg susultimalinie
    ; cazul in care ne aflam pe prima coloana a jumatatii de sus a matricei
    cmp ebx, 0
    je susprimacol
    ; cazul in care ne aflam pe ultima coloana a jumatatii de sus a matricei
    cmp ebx, 7
    je susultimacol
    xor esi, esi    ; in esi voi retine suma alcatuita din valorile vecinilor
    ; prin valoare ma refer la 2 la puterea pozitiei pe care se afla vecinul, retinuta in edx
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx    
    mov edi, 1      ; pentru a calcula puterea, am folosit o bucla
    loop1:
        shl edi, 1  ; am shiftat la stanga de un numar de ori egal cu puterea necesara
        dec eax
        cmp eax, 0
        jne loop1
    add esi, edi    ; am adaugat valoarea obtinuta la suma
    add edx, 2      ; vecinul din dreapta sus
    mov eax, edx    ; am repetat procedeul pentru fiecare vecin
    mov edi, 1
    loop2:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop2
    add esi, edi
    sub edx, 16     ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop3:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop3
    add esi, edi    
    sub edx, 2      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop4:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop4
    add esi, edi
    mov dword[ecx], esi     ; la final am adaugat valoarea obtinuta in board[0]
    jmp gata

jos:
    ; cazul in care ne aflam pe prima linie a jumatatii de jos a matricei
    cmp edx, 8
    jl josprimalinie
    ; cazul in care ne aflam pe ultima linie a jumatatii de jos a matricei
    cmp edx, 23
    jg josultimalinie
    ; cazul in care ne aflam pe prima coloana a jumatatii de jos a matricei
    cmp ebx, 0
    je josprimacol
    ; cazul in care ne aflam pe ultima coloana a jumatatii de jos a matricei
    cmp ebx, 7
    je josultimacol
    xor esi, esi    ; in esi voi retine suma alcatuita din valorile vecinilor
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop5:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop5
    add esi, edi
    add edx, 2      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop6:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop6
    add esi, edi
    sub edx, 16     ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop7:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop7
    add esi, edi
    sub edx, 2      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop8:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop8
    add esi, edi
    mov dword[ecx + 4], esi     ; la final am adaugat valoarea obtinuta in board[1]
    jmp gata

susprimalinie:
    ; cazul in care sunt pe prima linie din matricea de sus si pe prima coloana
    cmp ebx, 0
    je susprimalinieprimacoloana
    ; cazul in care sunt pe prima linie din matricea de sus si pe ultima coloana
    cmp ebx, 7
    je susprimalinieultimacoloana
    xor esi, esi    ; calculez mai intai suma vecinilor din jumatatea de sus a matricei
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop9:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop9
    add esi, edi
    add edx, 2      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop10:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop10
    add esi, edi
    mov [ecx], esi   ; am adaugat suma obtinuta in board[0]
    xor esi, esi     ; calculez suma vecinilor din jumatatea de jos a matricei
    add edx, 14      ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop11:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop11
    add esi, edi
    add edx, 2      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop12:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop12
    add esi, edi
    mov [ecx + 4], esi    ; am adaugat suma obtinuta in board[1]
    jmp gata

susprimalinieprimacoloana:
    ; am un vecin in prima jumatate si un vecin in cea de-a doua jumatate
    add edx, 9      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop13:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop13
    mov dword[ecx], edi     ; am adaugat suma obtinuta in board[0]
    add edx, 16     ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop14:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop14
    mov dword[ecx + 4], edi     ; am adaugat suma obtinuta in board[1]
    jmp gata

susprimalinieultimacoloana:
    ; am un vecin in prima jumatate si un vecin in cea de-a doua jumatate
    add edx, 7      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop15:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop15
    mov dword[ecx], edi     ; am adaugat suma obtinuta in board[0]
    add edx, 16     ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop16:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop16
    mov dword[ecx + 4], edi     ; am adaugat suma obtinuta in board[1]
    jmp gata


susultimalinie:
    ; cazul in care sunt pe prima linie din matricea de sus si pe prima coloana
    cmp ebx, 0
    je susultimalinieprimacoloana
    ; cazul in care sunt pe prima linie din matricea de sus si pe ultima coloana
    cmp ebx, 7
    je susultimalinieultimacoloana
    xor esi, esi    ; calculez mai intai suma vecinilor din jumatatea de sus a matricei
    sub edx, 9      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop17:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop17
    add esi, edi
    add edx, 2      ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop18:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop18
    add esi, edi
    mov dword[ecx], esi     ; am adaugat suma obtinuta in board[0]
    jmp gata

susultimalinieprimacoloana:
    ; am un singur vecin in cea de-a doua jumatate
    sub edx, 7      ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop19:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop19
    mov dword[ecx], edi     ; am adaugat valoarea vecinului in board[0]
    jmp gata

susultimalinieultimacoloana:
    ; am un singur vecin in cea de-a doua jumatate
    sub edx, 9      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop20:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop20
    mov dword[ecx], edi     ; am adaugat valoarea vecinului in board[0]
    jmp gata

susprimacol:
    xor esi, esi
    add edx, 9      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop21:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop21
    add esi, edi
    sub edx, 16     ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop22:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop22
    add esi, edi
    mov dword[ecx], esi     ; am adaugat suma obtinuta in board[0]
    jmp gata

susultimacol:
    xor esi, esi
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop23:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop23
    add esi, edi
    sub edx, 16     ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop24:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop24
    add esi, edi
    mov dword[ecx], esi     ; am adaugat suma obtinuta in board[0]
    jmp gata

josultimalinie:
    ; cazul in care sunt pe ultima linie din matricea de jos si pe prima coloana
    cmp ebx, 0
    je josultimalinieprimacoloana
    ; cazul in care sunt pe ultima linie din matricea de jos si pe ultima coloana
    cmp ebx, 7
    je josultimalinieultimacoloana
    xor esi, esi    ; calculez mai intai suma vecinilor din jumatatea de jos a matricei
    sub edx, 7      ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop25:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop25
    add esi, edi
    sub edx, 2      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop26:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop26
    add esi, edi
    mov dword[ecx + 4], esi     ; am adaugat suma obtinuta in board[1]
    xor esi, esi    ; calculez suma vecinilor din jumatatea de sus a matricei
    sub edx, 14     ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop27:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop27
    add esi, edi
    sub edx, 2      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop28:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop28
    add esi, edi
    mov dword[ecx], esi     ; am adaugat suma obtinuta in board[0]
    jmp gata

josultimalinieprimacoloana:
    ; am un vecin in prima jumatate si un vecin in cea de-a doua jumatate
    sub edx, 7      ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop40:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop40
    mov dword[ecx + 4], edi     ; am adaugat valoarea vecinului in board[1]
    sub edx, 16     ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop29:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop29
    mov dword[ecx], edi     ; am adaugat valoarea vecinului in board[0]
    jmp gata

josultimalinieultimacoloana:
    sub edx, 9      ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop30:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop30
    mov dword[ecx + 4], edi     ; am adaugat valoarea vecinului in board[1]
    sub edx, 16     ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop31:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop31
    mov dword[ecx], edi     ; am adaugat valoarea vecinului in board[0]
    jmp gata

josprimalinie:
    ; cazul in care sunt pe prima linie din matricea de jos si pe prima coloana
    cmp ebx, 0
    je josprimalinieprimacoloana
    ; cazul in care sunt pe prima linie din matricea de jos si pe ultima coloana
    cmp ebx, 7
    je josprimalinieultimacoloana
    xor esi, esi
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop32:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop32
    add esi, edi
    add edx, 2      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop33:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop33
    add esi, edi
    mov dword[ecx + 4], esi     ; am adaugat suma obtinuta in board[1]
    jmp gata

josprimalinieprimacoloana:
    ; am un singur vecin in prima jumatate
    add edx, 9      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop34:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop34
    mov dword[ecx + 4], edi     ; am adaugat valoarea vecinului in board[1]
    jmp gata

josprimalinieultimacoloana:
    ; am un singur vecin in prima jumatate
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop35:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop35
    mov dword[ecx + 4], edi     ; am adaugat valoarea vecinului in board[1]
    jmp gata

josprimacol:
    xor esi, esi
    add edx, 9      ; vecinul din dreapta sus
    mov eax, edx
    mov edi, 1
    loop36:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop36
    add esi, edi
    sub edx, 16     ; vecinul din dreapta jos
    mov eax, edx
    mov edi, 1
    loop37:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop37
    add esi, edi
    mov dword[ecx + 4], esi     ; am adaugat suma obtinuta in board[1]
    jmp gata

josultimacol:
    xor esi, esi
    add edx, 7      ; vecinul din stanga sus
    mov eax, edx
    mov edi, 1
    loop38:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop38
    add esi, edi    
    sub edx, 16     ; vecinul din stanga jos
    mov eax, edx
    mov edi, 1
    loop39:
        shl edi, 1
        dec eax
        cmp eax, 0
        jne loop39
    add esi, edi
    mov dword[ecx + 4], esi     ; am adaugat suma obtinuta in board[1]
    jmp gata

gata:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY