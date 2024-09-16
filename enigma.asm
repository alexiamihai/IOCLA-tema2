%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE

    mov edi, eax    ; am retinut in edi numarul mutarilor
    ; am verificat pe ce rotor ma alfu
    cmp ebx, 0
    je rotor0
    cmp ebx, 1
    je rotor1
    cmp ebx, 2
    je rotor2

rotor0:
    mov ecx, [ebp + 16]     ; daca rotorul este 0, raman pe linia initiala
    jmp decizie

rotor1:
    add ecx, 52     ; daca rotorul este 1, ma mut pe linia 3
    jmp decizie
rotor2:
    add ecx, 104    ; daca rotorul este 1, ma mut pe linia 5
    jmp decizie

decizie:
    cmp edi, 0      ; cazul in care nu trebuie efectuata nicio mutare
    je ready
    cmp edx, 0      ; cazul in care trebuie sa mut la stanga
    je shift_rotor_left
    cmp edx, 0      ; cazul in care nu trebuie sa mut la dreapta
    jne shift_rotor_right
shift_rotor_left:
    xor esi, esi    ; contorul cu care interez prin linie
    mov edx, 1      ; contorul cu care verific daca s-au realizat toate shiftarile
shift_prima_linie:
    xor esi, esi    ; am shiftat fiecare linie pe rand
    mov bl, byte [ecx + esi]    ; am retinut primul caracter din linie
shift_line_left:
    mov al, byte [ecx + esi + 1]    ; am retinut caracterul de pe pozitia esi+1
    mov [ecx + esi], al             ; si l-am mutat pe pozitia i
    inc esi                         ; am trecut la urmatorul caracter
    cmp esi, 25                     ; am verificat daca s-a ajuns la finalul buclei
    jl shift_line_left

    mov [ecx + esi], bl     ; am pus caracterul retinut pe ultima pozitie
    inc edx                 ; am crescut numarul de mutari efectuate
    cmp edx, edi            ; am verificat daca am shiftat de suficiente ori
    jle shift_prima_linie

    mov edx, 1              
    add ecx, 26             ; am trecut la shiftarea celei de-a doua linii
    xor esi, esi            ; si am repetat procedeul
shift_a_doua_linie:    
    xor esi, esi
    mov bl, byte [ecx + esi]   
shift_line2_left:
    mov al, byte [ecx + esi + 1]
    mov  [ecx + esi], al
    inc esi ; Trecem la următorul element din linie
    cmp esi, 25
    jl shift_line2_left

    mov [ecx + esi], bl
    mov bl, byte [ecx + esi]
    xor esi, esi
    inc edx
    cmp edx, edi
    jle shift_a_doua_linie
    jmp ready

shift_rotor_right:
    xor esi, esi        ; contorul cu care interez prin linie
    mov edx, 1          ; contorul cu care verific daca s-au realizat toate shiftarile
shift_prima_linie_r:
    mov esi, 25         ; am pornit de la ultimul caracter al liniei
    mov bl, byte [ecx + esi]        ; pe care l-am retinut in bl
shift_line_right:
    dec esi                         ; s-a trecut la elementul de dinainte
    mov al, byte [ecx + esi]        ; am retinut caracterul de pe pozitia i
    mov  [ecx + esi + 1], al        ; si l-am mutat pe pozitia i+1
    cmp esi, 1                      ; am verificat daca am ajuns la inceputul liniei
    jge shift_line_right
    
    mov [ecx], bl       ; am mutat caracterul retinut pe prima pozitie
    inc edx             ; am verificat daca am shiftat de suficiente ori
    cmp edx, edi
    jle shift_prima_linie_r
    xor esi, esi    
    mov edx, 1      
    add ecx, 26         ; am trecut la urmatoarea linie si am procedat la fel
shift_a_doua_linie_r:
    mov esi, 25
    mov bl, byte [ecx + esi]
shift_line2_right:
    dec esi
    mov al, byte [ecx + esi]
    mov  [ecx + esi + 1], al
    cmp esi, 1
    jge shift_line2_right
    
    mov [ecx], bl
    mov bl, byte [ecx + esi]
    inc edx
    cmp edx, edi
    jle shift_a_doua_linie_r
    jmp ready

ready:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY