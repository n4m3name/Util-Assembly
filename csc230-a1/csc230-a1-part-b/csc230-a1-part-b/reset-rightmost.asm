; reset-rightmost.asm
; CSC 230: Fall 2022
;
; Code provided for Assignment #1
;
; Mike Zastre (2022-Sept-22)

; This skeleton of an assembly-language program is provided to help you
; begin with the programming task for A#1, part (b). In this and other
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
; Your task: You are to take the bit sequence stored in R16,
; and to reset the rightmost contiguous sequence of set
; by storing this new value in R25. For example, given
; the bit sequence 0b01011100, resetting the right-most
; contigous sequence of set bits will produce 0b01000000.
; As another example, given the bit sequence 0b10110110,
; the result will be 0b10110000.
;
; Your solution must work, of course, for bit sequences other
; than those provided in the example. (How does your
; algorithm handle a value with no set bits? with all set bits?)

; ANY SIGNIFICANT IDEAS YOU FIND ON THE WEB THAT HAVE HELPED
; YOU DEVELOP YOUR SOLUTION MUST BE CITED AS A COMMENT (THAT
; IS, WHAT THE IDEA IS, PLUS THE URL).

    .cseg
    .org 0

; ==== END OF "DO NOT TOUCH" SECTION ==========

	      ; ldi r16, 0b01011100
		   ldi r16, 0b11100100


	; THE RESULT **MUST** END UP IN R25

; **** BEGINNING OF "STUDENT CODE" SECTION **** 

; Your solution here.

; Idea: Similar to 1st soln, except use mask for both comparison
; and flipping of req'd bits.

.def mask = r17; mask used to compare
	ldi r17, 0x01

.def nmask = r18; mask used to zero bits of interest

.def hold = r19; holds value of [bit & mask]

.def c = r20; count
	ldi c, 0x00

.def num = r25; holds new number
	mov num, r16; set as original num


LOOP: cpi c, 0x08; if all 0's
	breq reset_rightmost_stop; Stop once mask has reached final digit

	mov hold, num; ...
	AND hold, mask; mask num
	cp hold, mask; Compare num bit w mask
	breq flip; if even go to flip

	INC c; ...
	LSL mask; shift mask one bit left
	rjmp loop; ret to loop start

flip: ; flips 1st, following bits until reaches 0 or c=8
	LOOPF: cp hold, mask; catch 0
		brne reset_rightmost_stop; end if 0
		cpi c, 0x08; catch c=8
		breq reset_rightmost_stop; end if c=8

		MOV nmask, mask; ...
		COM nmask; invert nmask
		AND num, nmask; flip only bit of interest
		LSL mask; shift mask one bit left
		mov hold, num; ...
		AND hold, mask; mask num
		INC c; ...

		rjmp loopf

; **** END OF "STUDENT CODE" SECTION ********** 



; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
reset_rightmost_stop:
    rjmp reset_rightmost_stop


; ==== END OF "DO NOT TOUCH" SECTION ==========
