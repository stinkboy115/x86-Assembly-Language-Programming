INCLUDE irvine32.inc

.DATA
studentData  DWORD 29, "Alice", 72, "Bob", 98, "Charlie", 13, "David", 87, "Emily", 66, "Frank", 52, "Grace", 51, "Henry", 36, "Isabel"
sortedData   DWORD 10 DUP (2 DUP (?))   
gradeCounts  BYTE 0, 0, 0, 0, 0          

.CODE
SelectionSort PROC
    mov ecx, LENGTHOF studentData / 4  
    mov esi, OFFSET studentData        

    mov ebx, 0                         
outerLoop:
    mov edx, ebx                       
    mov eax, [esi + edx * 8]           

    mov edi, ebx                      
    inc edi                          

innerLoop:
    mov ecx, [esi + edi * 8]           
    cmp ecx, eax                       
    jle skipSwap                       

    xchg eax, ecx
    mov [esi + edx * 8], eax
    mov [esi + edi * 8], ecx

    mov eax, [esi + edx * 8 + 4]       
    mov ecx, [esi + edi * 8 + 4]
    mov [esi + edx * 8 + 4], ecx
    mov [esi + edi * 8 + 4], eax

skipSwap:
    inc edi                            
    cmp edi, LENGTHOF studentData / 4  
    jne innerLoop

    inc ebx                            
    cmp ebx, LENGTHOF studentData / 4 
    jne outerLoop

    ret
SelectionSort ENDP

AssignLetterGrades PROC
    mov esi, OFFSET studentData        
    mov ecx, LENGTHOF studentData / 2 

AssignLoop:
    cmp ecx, 0
    je DoneAssigning

    mov eax, [esi]                
    cmp eax, 90
    jge GradeA
    cmp eax, 80
    jge GradeB
    cmp eax, 70
    jge GradeC
    cmp eax, 60
    jge GradeD
    jmp GradeF

GradeA:
    mov BYTE PTR [esi + 4], 'A'   
    jmp NextStudent

GradeB:
    mov BYTE PTR [esi + 4], 'B'   
    jmp NextStudent

GradeC:
    mov BYTE PTR [esi + 4], 'C'   
    jmp NextStudent

GradeD:
    mov BYTE PTR [esi + 4], 'D'   
    jmp NextStudent

GradeF:
    mov BYTE PTR [esi + 4], 'F'   

NextStudent:
    add esi, TYPE studentData * 2  
    loop AssignLoop                 

DoneAssigning:
    ret
AssignLetterGrades ENDP
CountGrades PROC
    mov esi, OFFSET sortedData         
    mov ecx, LENGTHOF sortedData / 2  
    mov edx, 0                        
    mov ebx, 0                        
    mov edi, 0                        
    mov eax, 0                        
    mov ecx, 0                        

CountLoop:
    cmp ecx, LENGTHOF sortedData / 2  
    je PrintCounts                    

    mov al, BYTE PTR [esi + TYPE sortedData]  
    cmp al, 'A'
    je IncrementA
    cmp al, 'B'
    je IncrementB
    cmp al, 'C'
    je IncrementC
    cmp al, 'D'
    je IncrementD
    cmp al, 'F'
    je IncrementF

IncrementA:
    inc edx
    jmp NextCount
IncrementB:
    inc ebx
    jmp NextCount
IncrementC:
    inc edi
    jmp NextCount
IncrementD:
    inc eax
    jmp NextCount
IncrementF:
    inc ecx
    jmp NextCount

NextCount:
    add esi, TYPE sortedData * 2    
    loop CountLoop                  
PrintCounts:
    ; Print the counts of each grade
    mov edx, OFFSET msgA
    call WriteString
    mov edx, edx
    call WriteDec
    call Crlf

    mov edx, OFFSET msgB
    call WriteString
    mov edx, ebx
    call WriteDec
    call Crlf

    mov edx, OFFSET msgC
    call WriteString
    mov edx, edi
    call WriteDec
    call Crlf

    mov edx, OFFSET msgD
    call WriteString
    mov edx, eax
    call WriteDec
    call Crlf

    mov edx, OFFSET msgF
    call WriteString
    mov edx, ecx
    call WriteDec
    call Crlf

    ret

    msgA db "Count of A's: ", 0
    msgB db "Count of B's: ", 0
    msgC db "Count of C's: ", 0
    msgD db "Count of D's: ", 0
    msgF db "Count of F's: ", 0

CountGrades ENDP


main PROC
    call SelectionSort
    call AssignLetterGrades
    call CountGrades

    mov eax, 0
    ret
main ENDP

END main