		;		ARM Programming Assignment #4: Encode in Hamming(15, 11)
		;
		;		Write a subroutine that encodes 11 bits of data into a 15-bit
		;		block, using 4 parity bits. Assume even parity, that is,
		;		the parity of the bits covered by a parity bit, including
		;		the parity bit, has to be an even number. Assume the bits are
		;		written in the following sequence: p1, p2, d1, p4, d2, d3, d4,
		;		p8, d5, d6, d7, d8, d9, d10, d11, p16, d12, d13, d14, d15.
		;		Call the subroutine `hencode`.
		;
		;		Write a subroutine that decodes a H(15, 11) block to extract
		;		the 11 data bits. Call it `hdecode`. It should:
		;		- calculate the correcting code
		;		- dentify the case: no error (noer), one-bit error (onee)
		;		- write the result in `case` using the encoding provided
		;		- if there is a one-bit error, write the number of the
		;		erroneous bit in `berr`
		;		- if there is a one-bit error, correct the data
		;		- write the result in `corr`
		;
		;		Now, write a main function which uses `hencode` and `decode`
		;		to encode `data` and then, after a simulated transmission,
		;		decode `recv`. Assume that `recv` contains what is received
		;		at the other end.
		
		;		Your code here
		
data		DCD		0b10100100101
recv		DCD		0b101111010100101
		
noer		DCD		0x00
onee		DCD		0x01
		
case		FILL		4
berr		FILL		4
corr		FILL		4
		
hencode
		ADR		R0, data
		LDR		R0, [R0, #0]
		AND		R1, R0, #0b1111111
		LSR		R2, R0, #7
		AND		R2, R2, #0b111
		LSL		R2, R2, #8
		ADD		R1, R1, R2
		LSR		R2, R0, #10
		LSL		R2, R2, #12
		ADD		R1, R2, R1
		MOV		R0, #0
		MOV		R2, #1
		MOV		R3, R1
		MOV		R4, #15
		MOV		R6, #1
		STMIA	SP, {R0-R4, R6}
mainL
		LSL		R3, R3, #1
		ADD		R0, R0, #1
		CMP		R0, R2
		BLT		xor
		MOV		R0, #0
		B		next
next
		CMP		R6, #8
		BEQ		parBit
		LSL		R3, R3, #1
		ADD		R0, R0, #1
		CMP		R0, R2
		Blt		next
		MOV		R0, #0
		B		xor
parBit
		MOV		R6, #1
		SUB		R5, R4, R2
		LSL		R5, R6, R5
		AND		R5, R1, R5
		LDMIA	SP, {R0-R4, R6}
		ORR		R1, R1, R5
		LSL		R2, R2, #1
		STMIA	SP, {R0-R4, R6}
		CMP		R2, #8
		BLE		mainL
		B		done
xor
		EOR		R1, R1, R3
		ADD		R0, R0, #1
		LSL		R3, R3, #1
		ADD		R6, R6, #1
		CMP		R0, R2
		BLT		xor
		MOV		R0, #0
		
		
done
		END
