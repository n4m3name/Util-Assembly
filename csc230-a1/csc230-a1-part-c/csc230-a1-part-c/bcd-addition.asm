; bcd-addition.asm
; CSC 230: Fall 2022
;
; Code provided for Assignment #1
;
; Mike Zastre (2022-Sept-22)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (c). In this and other
; files provided through the semester, you will see lines of code
; indicating "DO NOT TOUCH" sections. You are *not* to modify the
; lines within these sections. The only exceptions are for specific
; changes announced on conneX or in written permission from the course
; instructor. *** Unapproved changes could result in incorrect code
; execution during assignment evaluation, along with an assignment grade
; of zero. ****
;
; In a more positive vein, you are expected to place your code with the
; area marked "STUDENT CODE" sections.

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; Your task: Two packed-BCD numbers are provided in R16
; and R17. You are to add the two numbers together, such
; the the rightmost two BCD "digits" are stored in R25
; while the carry value (0 or 1) is stored R24.
;
; For example, we know that 94 + 9 equals 103. If
; the digits are encoded as BCD, we would have
;   *  0x94 in R16
;   *  0x09 in R17
; with the result of the addition being:
;   * 0x03 in R25
;   * 0x01 in R24
;
; Similarly, we know than 35 + 49 equals 84. If 
; the digits are encoded as BCD, we would have
;   * 0x35 in R16
;   * 0x49 in R17
; with the result of the addition being:
;   * 0x84 in R25
;   * 0x00 in R24
;

; ANY SIGNIFICANT IDEAS YOU FIND ON THE WEB THAT HAVE HELPED
; YOU DEVELOP YOUR SOLUTION MUST BE CITED AS A COMMENT (THAT
; IS, WHAT THE IDEA IS, PLUS THE URL).



    .cseg
    .org 0

	; Some test cases below for you to try. And as usual
	; your solution is expected to work with values other
	; than those provided here.
	;
	; Your code will always be tested with legal BCD
	; values in r16 and r17 (i.e. no need for error checking).

	; 94 + 9 = 03, carry = 1
	; ldi r16, 0x94
	; ldi r17, 0x09

	; 86 + 79 = 65, carry = 1
	 ldi r16, 0x86
	 ldi r17, 0x79

	; 35 + 49 = 84, carry = 0
	; ldi r16, 0x35
	; ldi r17, 0x49

	; 32 + 41 = 73, carry = 0
	; ldi r16, 0x32
 	; ldi r17, 0x41
	

; ==== END OF "DO NOT TOUCH" SECTION ==========

; **** BEGINNING OF "STUDENT CODE" SECTION **** 

; Idea:
; Define upper, lower nibble. Add lower.
; If >9, add 1 to upper. Add upper.
; Id > 9, add 1 to carry.
; Combine.

; Define upper, lower nibble, carry and sum registers
.def hiA = r18
	mov hiA, r16
	SWAP hiA; swap
	CBR hiA, 0xF0; mask

.def hiB = r19
	mov hiB, r17
	SWAP hiB; swap
	CBR hiB, 0xF0; mask

.def loA = r20
	mov loA, r16
	CBR loA, 0xF0; mask

.def loB = r21
	mov loB, r17
	CBR loB, 0xF0; mask

.def c = r24

.def sum = r25

; Add lo
	ADD loA, loB
	cpi loA, 0x0A
	BRGE cLo

cont:
	; Add hi
	ADD hiA, hiB
	cpi hiA, 0x0A
	BRGE cHi

contd:
	; Place lo digit
	mov sum, loA

	; Place hi digit
	SWAP hiA
	ADD sum, hiA
	rjmp bcd_addition_end

; Handle carry for lo
cLo:
	INC hiA
	SUBI loA, 0x0A
	rjmp cont

; Handle carry for hi
cHi:
	inc c
	SUBI hiA, 0x0A
	rjmp contd

; **** END OF "STUDENT CODE" SECTION ********** 

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
bcd_addition_end:
	rjmp bcd_addition_end



; ==== END OF "DO NOT TOUCH" SECTION ==========
