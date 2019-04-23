	.data
Encode: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
StrOut: .space 80
StrIn:	.space 80
InputPrompt: .asciiz "Base64 to decode: "
	.globl main
	.text

main:	
		#each char is represented as 00______ in binary (leq 64)
		# K        G        l        0
		# 10       6        37       52
		# 00001010 00000110 00100101 00110100
		# 8b 1: shift left 2
		# 8b 2: shift right 4
		# 001010|00 + 000000|00 = 001010|00
		# add to output string
		# 8b 2: shift left 4
		# 8b 3: shift right 2
		# 0110|0000 + 0000|1001 = 0110|1001
		# 8b 3: shift left 6
		# 8b 4: don't shift
		# 01|000000 + 00|110100 = 01|110100
		
		li $v0, 4
		la $a0, InputPrompt
		syscall
		
		li $v0, 8		#Read string syscall
		la $a0, StrIn	#&StrIn
		li $a1, 80		#Allocate 80 bytes for StrIn
		syscall	

		la $s7, StrOut
		la $t2, StrIn
Loop:
		# Find numeric val for ch1 (n1)
		lb $t3, 0($t2)	#Get ch1
		addi $t2, 1		#*StrIn++
		jal GetNum		#Decrypt
		move $t4, $t3	#Decrypt return
		
		# Find numeric val for ch2 (n2)
		lb $t3, 0($t2)	#Get ch2
		addi $t2, 1		#*StrIn++
		jal GetNum		#Decrypt
		move $t5, $t3	#Decrypt return
		
		# Find numeric val for ch3 (n3)
		lb $t3, 0($t2)	#Get ch3
		addi $t2, 1 	#*StrIn++
		jal GetNum		#Decrypt
		move $t6, $t3	#Decrypt return
		
		# Find numeric val for ch4 (n4)
		lb $t3, 0($t2)	#Get ch4
		addi $t2, 1		#*StrIn++
		jal GetNum		#Decrypt
		move $t7, $t3	#Decrypt return
		
		#t4 = n1
		#t5 = n2
		#t6 = n3
		#t7 = n4
		
		# Two shift registers: Initialize one to 2, other to 4
		li $t0, 2 #regSL
		li $t1, 4 #regSR
		
		sllv $t8, $t4, $t0 	# n1 << regSL
		srlv $t9, $t5, $t1	# n2 >> regSR
		or $t8, $t8, $t9	# n1 || n2
		sb $t8, 0($s7) 		# out += n1||n2
		addi $s7, 1  		# *out++
		addi $t0, 2  		# regSL += 2
		addi $t1, -2 		# regSR -= 2
		
		sllv $t8, $t5, $t0	# n2 << regSL
		srlv $t9, $t6, $t1	# n3 >> regSR
		or $t8, $t8, $t9	# n2 || n3
		sb $t8, 0($s7)		# out += n2 || n3
		addi $s7, 			# *out++
		addi $t0, 2			# regSL += 2
		addi $t1, -2		# regSR -= 2
		
		sllv $t8, $t6, $t0	# n3 << regSL
		srlv $t9, $t7, $t1	# n4 >> regSR
		or $t8, $t8, $t9	# n3 || n4
		sb $t8, 0($s7)		# out += n3 || n4
		addi $s7, 1			# *out++
		
		lb $t3, 0($t2)		# Get ch5
		bne $t3, 10, Loop	# (ch5 == delim)?loop:break
		# }
		
		# Print output string and end
		li $v0, 4
		la $a0, StrOut
		syscall
end:
		li $v0, 10
		syscall

GetNum:
	#t3 contains input character
	li $s0, 0 #Count
	la $s1, Encode
GetNumLoop:
	lb $s2, 0($s1)				# get byte of encoding string
	beq $s2, $t3, GetNumReturn	# (input == Encode[i])?continue
	
	addi $s0, 1					# count++
	addi $s1, 1 				# *Encode++
	b GetNumLoop				# loop
GetNumReturn:
	move $t3, $s0 				# Overwrite input char with numerical value
	jr $ra						# Return
