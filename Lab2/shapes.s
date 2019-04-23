	.data
Promptx1:	.asciiz "x1: "
Prompty1:	.asciiz "y1: "
Promptx2:	.asciiz "x2: "
Prompty2:	.asciiz "y2: "
AreaCircle:	.asciiz "\nThe area of the circle is: "
AreaSquare:	.asciiz "\nThe area of the square is: "
AreaRect:	.asciiz "\nThe area of the rectangle is: "
PromptMenu:	.asciiz "\nTo quit enter 0\nTo calculate the area of a circle enter 1\nTo calculate the area of a square enter 2\nTo calculate the area of a enter 3\nEnter: "
	.globl main
	.text
	
main:
	li $v0, 4	#syscall print string
	la $a0, PromptMenu
	syscall
	li $v0, 5	#syscall read int
	syscall
	move $t6, $v0
	beq $v0, 0, End

#Get input
	li $v0, 4			#syscall print string
	la $a0, Promptx1	
	syscall				
	li $v0, 5			#syscall read int
	syscall				
	move $t0, $v0		#t0 = x1
	li $v0, 4			#syscall print string
	la $a0, Prompty1
	syscall
	li $v0, 5			#syscall read int
	syscall
	move $t1, $v0		#t1 = y1
	li $v0, 4			#syscall print string
	la $a0, Promptx2
	syscall
	li $v0, 5			#syscall read int
	syscall
	move $t2, $v0		#t2 = x2
	li $v0, 4			#syscall print string
	la $a0, Prompty2
	syscall
	li $v0, 5			#syscall read int
	syscall
	move $t3, $v0		#t3 = y2
	
	beq $t6, 1, Circle
	beq $t6, 2, Square
	beq $t6, 3, Rectangle
	
Circle: #Area of circle
	sub $t4, $t2, $t0	#t4 = x2 - x1
	mult $t4, $t4		#LO = (x2 - x1)^2
	mflo $t4			#$t4 = (x2 - x1)^2
	
	sub $t5, $t3, $t1	#t5 = y2 - y1
	mult $t5, $t5		#LO = (y2 - y1)^2
	mflo $t5			#t5 = (y2 - y1)^2
	
	add $t4, $t4, $t5	#t4 = radius squared
	li $t5, 314156		#t5 = pi
	
	mult $t4, $t5		#LO = area
	mflo $t4			#t4 = area
	li $t5, 100000		#t5 = 100000
	div $t4, $t5		#LO = answer
	mflo $t4			#t4 = answer
	
	li $v0, 4			#syscall print string
	la $a0, AreaCircle
	syscall
	li $v0, 1			#syscall print int
	move $a0, $t4
	syscall
	
	b main
	
Square: #Area of square
	sub $t4, $t2, $t0	#t4 = x2 - x1
	mult $t4, $t4		#LO = (x2 - x1)^2
	mflo $t4			#$t4 = (x2 - x1)^2
	
	sub $t5, $t3, $t1	#t5 = y2 - y1
	mult $t5, $t5		#LO = (y2 - y1)^2
	mflo $t5			#t5 = (y2 - y1)^2
	
	add $t4, $t4, $t5	#t4 = side squared; area of square
	
	li $v0, 4			#syscall print string
	la $a0, AreaSquare
	syscall
	li $v0, 1	#syscall print int
	move $a0, $t4
	syscall
	
	b main
	
Rectangle:	#Area of rectangle
	sub $t4, $t2, $t0	#t4 = x2 - x1
	sub $t5, $t3, $t1	#t5 = y2 - y1
	mult $t4, $t5
	mflo $t4
	
	li $v0, 4			#syscall print string
	la $a0, AreaRect
	syscall
	li $v0, 1	#syscall print int
	move $a0, $t4
	syscall
	
	b main
End:
	li $v0, 10
	syscall