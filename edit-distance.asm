; main.asm for edit-distance assignment
;
; CSC 230: Fall 2022
;
; Code provided for Assignment #1
;
; Mike Zastre (2022-Sept-22)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (a). In this and other
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
;
; Your task: To compute the edit distance between two byte values,
; one in R16, the other in R17. If the first byte is:
;    0b10101111
; and the second byte is:
;    0b10011010
; then the edit distance -- that is, the number of corresponding
; bits whose values are not equal -- would be 4 (i.e., here bits 5, 4,
; 2 and 0 are different, where bit 0 is the least-significant bit).
; 
; Your solution must, of course, work for other values than those
; provided in the example above.
;
; In your code, store the computed edit distance value in R25.
;
; Your solution is free to modify the original values in R16
; and R17.
;
; ANY SIGNIFICANT IDEAS YOU FIND ON THE WEB THAT HAVE HELPED
; YOU DEVELOP YOUR SOLUTION MUST BE CITED AS A COMMENT (THAT
; IS, WHAT THE IDEA IS, PLUS THE URL).

    .cseg
    .org 0

; ==== END OF "DO NOT TOUCH" SECTION ==========

	;ldi r16, 0xa7
	;ldi r17, 0x9a
	ldi r16, 0b11111111
	ldi r17, 0b11111111

; **** BEGINNING OF "STUDENT CODE" SECTION **** 

	; Your solution in here.

	; THE RESULT **MUST** END UP IN R25

	.def bits = r18; Holds XOR of r16, r17
		mov bits, r16
		EOR bits, r17

	.def hold = r20; Use to hold value of [bits & mask]
		ldi hold, 0x00

	.def c = r21; Use for loop increment
		ldi c, 0x00

	.def countBits = r25; Use to store number of bits
		ldi countBits, 0x00


	LOOP: cpi c, 0x08
		breq edit_distance_stop; Stop program after 8 comparisons

		mov hold, bits; load bits into hold
		ANDI hold, 0x01; mask bits
		cpi hold, 0x01; if bit is 1,
		breq plus; increment

		LSR bits; shift bits right to compare next bit
		inc c; increment c
		rjmp loop; return to loop start

plus: ; increments bit counter
	inc countBits
	LSR bits; shift bits right to compare next bit
	inc c; increment c
	rjmp loop; return to loop start
		

; **** END OF "STUDENT CODE" SECTION ********** 

; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
edit_distance_stop:
    rjmp edit_distance_stop



; ==== END OF "DO NOT TOUCH" SECTION ==========
