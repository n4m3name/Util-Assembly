# Bits-Assembly

Assignment 1 of CSC230 - Intro to Computer Architecture at UVic, written in AVR Assembly

A collection of assembly programs implementing various bit manipulation utilities.

## Programs

**BCD Addition**
- Performs Binary-Coded Decimal addition of two numbers
- Handles carry and overflow conditions
- Stores results in separate registers for sum and carry

**Edit Distance Calculator**
- Computes Hamming distance between two 8-bit values
- Counts differing bits between two binary numbers
- Optimized for ATmega2560 architecture

**Rightmost Bit Reset**
- Resets rightmost contiguous sequence of set bits
- Preserves all other bits in the original value
- Handles edge cases (all zeros, all ones)

## Implementation Details

**BCD Operations**
```assembly
; BCD addition example
ADD loA, loB    ; Add lower digits
cpi loA, 0x0A   ; Check for decimal overflow
BRGE cLo        ; Branch if carry needed
```

**Bit Manipulation**
```assembly
; Edit distance calculation
EOR bits, r17   ; XOR to find differing bits
ANDI hold, 0x01 ; Mask for bit counting
LSR bits        ; Shift right to check next bit
```

## Hardware Requirements
- Standard AVR development environment

## Notes

- All programs include proper stack initialization
- Error handling for invalid inputs
- Optimized for ATmega2560 instruction set
- Comments included for key algorithms
