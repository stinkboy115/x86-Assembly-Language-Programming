INCLUDE irvine32.inc

.DATA
studentData  	DB 29, 72, 98, 13, 87, 66, 52, 51, 36, 30           ; 2D students araray with their names
                DB "Alice", 0, "Bob", 0, "Charlie", 0, "David", 0, "Emily", 0, "Frank", 0, "Grace", 0, "Henry", 0, "Isabel", 0,"John", 0
                                                                    ; added 0 at the end of every name 
                                                                    ; strings must end with 0 and null character
sorted_arr		DB "Charlie" , 0, "Emily" , 0, "Bob", 0, "Frank", 0, "Grace", 0, "Henry", 0, "Isabel", 0, "John", 0 , "Alice", 0,  "David", 0
grades_arr		DB 10 dup(0)
gradeCounts  	DB 0, 0, 0, 0, 0          
msg1 			DB "Students Data",10,0
msg2 			DB "Students Data after sorting in descending order:",10,0
msg3 			DB "Student Grades: ",10,0
tempsize		DD 0
printColon		DB ": ",0
count 			DB 0
acount          DD 0
bcount          DD 0
ccount          DD 0
dcount          DD 0
fcount          DD 0

.CODE
SelectionSort PROC						; use Selection Sort to sort data in descending order
    
	mov ecx, 0							; i as index for outerLoop
    mov esi, OFFSET studentData			; for outerLoop 
	mov edi, esi
	add edi, 10
outerLoop:
    mov ebx, ecx 						; j as index for innerloop
	inc ebx								; j = i + 1
innerloop:
	mov al, [esi + ecx]					; arr[i]
	mov ah, [esi + ebx]					; arr[j]
	cmp ah, al							; if arr[j] > arr[i] then swap
	jl no_swap
	
	mov [esi + ebx], al					; arr[j] = arr[i]
	mov [esi + ecx], ah					; arr[i] = arr[j]
	
	no_swap:
	inc ebx								; j++
	cmp ebx, 9
	jl innerloop
    
	inc ecx								; i++
	cmp ecx, 9
	jl outerLoop
	
	ret
SelectionSort ENDP

AssignLetterGrades PROC
    mov esi, OFFSET studentData 
	mov edi, OFFSET grades_arr
    mov ecx, 10

AssignLoop:
    cmp ecx, 0
    je DoneAssigning

    mov al, [esi]                
    cmp al, 90
    jge GradeA
    cmp al, 80
    jge GradeB
    cmp al, 70
    jge GradeC
    cmp al, 60
    jge GradeD
    jmp GradeF

GradeA:
    mov BYTE PTR [edi], 'A'   
	inc edi
    jmp NextStudent

GradeB:
    mov BYTE PTR [edi], 'B'   
	inc edi
    jmp NextStudent

GradeC:
    mov BYTE PTR [edi], 'C'   
	inc edi
    jmp NextStudent

GradeD:
    mov BYTE PTR [edi], 'D'   
	inc edi
    jmp NextStudent

GradeF:
    mov BYTE PTR [edi], 'F'   
	inc edi
	
NextStudent:
    inc esi
    loop AssignLoop                 

DoneAssigning:
	
	mov edx, OFFSET msg3
	call WriteString
	
	mov ecx, 10								; number of students
	mov esi, OFFSET grades_arr				; pointer to the students scores
	mov edi, OFFSET sorted_arr     		   ; pointer to the students names
	lop:
		mov edx, edi
		call WriteString
		mov edx, OFFSET printColon
		call WriteString
		mov eax, 0
		mov al, [esi]
		call WriteChar
		call next_studentName
		inc esi
		call Crlf
	loop lop								; loop for number of students
	

    ret
AssignLetterGrades ENDP

CountGrades PROC

	mov esi, OFFSET grades_arr
	mov ecx, 0
CountLoop:
	cmp ecx, 10
    je PrintCounts   
	mov al, [esi]

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
    inc acount
    jmp NextCount
IncrementB:
    inc bcount
    jmp NextCount
IncrementC:
    inc ccount
    jmp NextCount
IncrementD:
    inc dcount
    jmp NextCount
IncrementF:
    inc fcount
    jmp NextCount
	
NextCount:
	inc ecx
	inc esi
    jmp CountLoop  	
	
PrintCounts:
    ; Print the counts of each grade
    mov edx, OFFSET msgcount
    call WriteString

    mov eax, [acount]
    call WriteDec
    
    mov eax, [bcount]
    call WriteDec
 
    mov eax, [ccount]
    call WriteDec

    mov eax, [dcount]
    call WriteDec
 
    mov eax, [fcount]
    call WriteDec
	call Crlf
    ret

	msgcount db "Grade Count: ABCDF | ",0

CountGrades ENDP

next_studentName PROC								; this proc calculates the size of the string and returns it
		
	mov eax, 0								; size counter 
	lop:
	mov al, [edi]							; ebx points to the first character in the string
	cmp al, 0								; end if the null character is found
	je endlop
    inc eax									; Increment counter 
	inc edi
    jmp lop

	endlop:
    inc edi
	
ret
next_studentName ENDP

print_Students PROC
	
	mov edx, OFFSET msg1					; print a message
	call WriteString
	
	mov ecx, 10								; number of students
	mov esi, OFFSET studentData				; pointer to the students scores

	lop:
		mov edx, edi
		call WriteString
		mov edx, OFFSET printColon
		call WriteString
		mov eax, 0
		mov al, [esi]
		call WriteDec
		call next_studentName
		inc esi
		call Crlf
	loop lop								; loop for number of students
	
ret
print_Students ENDP

main PROC
	mov edi, OFFSET studentData     		; pointer to the students names
    add edi, 10
	call print_Students
	call Crlf
	mov edx, OFFSET msg2
	call WriteString
	call SelectionSort
    mov edi, OFFSET sorted_arr     		; pointer to the students names
	call print_Students
	call Crlf
    call AssignLetterGrades
	call Crlf
    call CountGrades
    ret
main ENDP

END main