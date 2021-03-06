		;		ARM Programming Assignment #4: Count the ones in a binary number
		;
		;		Write a program that counts the number of ones in a binary number,
		;		stored in a word (4 bytes). Its loop should run no more times than there
		;		are ones in the number. Write the count in `numones`. For the example
		;		number given below, the loop should only run 8 times, counting 8 ones.
		;
		;		Hint:
		;		The first significant instruction in the loop is SUB r1, r1, 1, which
		;		decrements the number, assuming it's stored in register r1. Now,
		;		remember your logical operations.
		;
		;		Bonus:
		;		1. (20 extra points) For the shortest program (by instruction count),
		;		because this operation has to be FAST.
		;		2. (30 extra points) For extending the program to counting the ones
		;		in any word-aligned contiguous region of memory.
		
		;		Your code here
		
example	DCD		0x0010070f
numones	FILL		4
		
		ADR		R0, example
		LDR		R1, [R0, #0]
		MOV		R3, #8
		MOV		R4, #0
loop
		SUB		R1, R1, #1
		AND		R2, R1, #1
		ADD		R4, R4, R3
		CMP		R4, #8
		BEQ		done
		B		loop
		
done
		ADR		R0, numones
		STR		R2, [R0, #0]
		
