    .data
Prompt: .asciiz "\nEnter number to reverse add: "
Reversed: .asciiz " <=> "
Added1: .asciiz " + "
Added2: .asciiz " = "
Result: .asciiz "\nPalindrome: "
newL: 	.asciiz "\n"
	.globl main
	.text
main:
	li $v0, 4       #Syscall print string
	la $a0, Prompt
	syscall         #Prompt for input
	li $v0, 5       #Syscall read int
	syscall
	move $t0, $v0   #Store input in t1
	li $t2, 10	#No immediate div
Addition:
	li $t1, 0	#Store reversed int
	move $t5, $t0	#keep backup of original
	
RevLoop:	#n in $t0 is reversed, stored in $t1; uses up to $t5
	#remainder = n%10
	div $t0, $t2	#remainder = n%10
	mfhi $t3		#$t3:=remainder
	mflo $t4		#$t4:=n/10
	move $t0, $t4
	
	#reversedInteger = reversedInteger*10 + remainder
	mult $t1, $t2	#reversedInteger*10
	mflo $t1		#$t1:=reversedInteger*10
	add $t1, $t1, $t3	#$t1:=reversedInteger+remainder
	
	#n/=10
	move $t0, $t4	#$t0:=n/10
	bgtz $t0, RevLoop	#Loop if n > 0
#LoopEnd
#Print reverse:
	li $v0, 1			#Syscall print int
	move $a0, $t5
	syscall
	li $v0, 4			#Syscall print string
	la $a0, Reversed
	syscall
	li $v0, 1			#Syscall print int
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, newL
	syscall
	
	add $t0, $t1, $t5	#$t0:=n+reverse
	
	#Print addition
	li $v0, 1
	move $a0, $t5
	syscall
	li $v0, 4
	la $a0, Added1
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, Added2
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, newL
	syscall
	
	move $t6, $t0		#$t6:=Copy of n and reverse added
	
	li $t1, 0
CheckPal:
	#remainder = n%10
	div $t0, $t2	#remainder = n%10
	mfhi $t3		#$t3:=remainder
	mflo $t4		#$t4:=n/10
	move $t0, $t4
	
	#reversedInteger = reversedInteger*10 + remainder
	mult $t1, $t2	#reversedInteger*10
	mflo $t1		#$t1:=reversedInteger*10
	add $t1, $t1, $t3	#$t1:=reversedInteger+remainder
	
	#n/=10
	move $t0, $t4	#$t0:=n/10
	bgtz $t0, CheckPal	#Loop if n > 0
#EndLoop
	move $t0, $t1
	bne $t6, $t0, Addition
	
	li $v0, 4			#Syscall print string
	la $a0, Result
	syscall
	li $v0, 1			#Syscall print int
	move $a0, $t1
	syscall
	li $v0, 4			#Syscall print string
	la $a0, newL
	syscall
	
	b main
End:
	li $v0, 10
	syscall
