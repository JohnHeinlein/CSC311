	.data
PI:	.double 3.1416	#l.d $f20, PI
Promptx1:	.asciiz "x1: "
Prompty1:	.asciiz "y1: "
Promptx2:	.asciiz "x2: "
Prompty2:	.asciiz "y2: "
AreaCircle:	.asciiz "\nThe area of the circle is: "
AreaSquare:	.asciiz "\nThe area of the square is: "
AreaRect:	.asciiz "\nThe area of the rectangle is: "
	.globl main
	.text
	
main:
	#Get input
		#x1
	li $v0, 4			#Print string
	la $a0, Promptx1	
	syscall				
	li $v0, 7			#Read double
	syscall
	mov.d $f2, $f0		#$f2:=x1
		#y1
	li $v0, 4			#Print string
	la $a0, Prompty1	
	syscall				
	li $v0, 7			#Read double
	syscall
	mov.d $f4, $f0		#$f4:=y1
		#x2
	li $v0, 4			#Print string
	la $a0, Promptx2	
	syscall				
	li $v0, 7			#Read double
	syscall
	mov.d $f6, $f0		#$f6:=x2
		#y2
	li $v0, 4			#Print string
	la $a0, Prompty2	
	syscall				
	li $v0, 7			#Read double
	syscall
	mov.d $f8, $f0		#$f8:=y2
	#End get input:
		#$f2:=x1
		#$f4:=y1
		#$f6:=x2
		#$f8:=y2
	
	#Function calls
	jal Circle
	jal Square
	jal Rectangle
	
	#Quit
	li $v0, 10
	syscall

Circle:
	la $s0, GetLength
	jalr $s1, $s0
	
							#r^2 in $f12
	l.d $f14, PI			#$f14 = PI
	mul.d $f12, $f12, $f14 	#$f12 = r^2 * PI
	
	#print results
	li $v0, 4
	la $a0, AreaCircle
	syscall
	li $v0, 3
	syscall
	
	#return
	jr $ra

Square:
	la $s0, GetLength
	jalr $s1, $s0
	
	#print results
	li $v0, 4
	la $a0, AreaSquare
	syscall
	li $v0 3
	syscall
	
	#return
	jr $ra

Rectangle:
	la $s0, GetSides
	jalr $s1, $s0
	#$f10:= (x2 - x1), $f12:= (y2 - y1)
	mul.d $f12, $f12, $f10
	
	#print results
	li $v0, 4
	la $a0, AreaRect
	syscall
	li $v0 3
	syscall
	
	#return
	jr $ra

GetLength:
	#Input: 	$f2 - $f8
	#Output: 	$f12 (output register)
	#Work:		$f12 (diff x), $f10 (diff y)
	sub.d $f10, $f6, $f2	#$f10 = x2 - x1
	mul.d $f10, $f10, $f10	#$f10 = (x2 - x1)^2
	
	sub.d $f12, $f8, $f4	#$f12 = y2 - y1
	mul.d $f12, $f12, $f12	#$f12 = (y2 - y1)^2
	
	add.d $f12, $f10, $f12	#$f14 = side squared; area of square
	jr $s1

GetSides:
	#Input:		$f2 - $f8
	#Output:	$f10 = (x2 - x1), 
	#			$f12 = (y2 - y1)
	sub.d $f10, $f6, $f2	#$f10 = x2 - x1
	sub.d $f12, $f8, $f4	#$f12 = y2 - y1
	jr $s1
