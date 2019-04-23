	.data
hex1:		.asciiz "\n0xaaaaaaaa: "
hex2:		.asciiz "\n0x24924924: "
intprompt:	.asciiz "Int to look for: "
noInSet:	.asciiz "           Int not in set"
yesInSet:	.asciiz "           Int in set"
unionStr:		.asciiz "Union:        "
intersectStr:	.asciiz "Intersection: "
openBrace:	.asciiz "{ "
endBrace:	.asciiz "}"
space:		.asciiz " "
newline:	.asciiz "\n"

	.globl main
	.text

main:
	#t0 = mask
	li $t1, 33	#when to quit
	#$t2 = count
	li $t3, 0xaaaaaaaa	#set 1
	li $t4, 0x24924924	#set 2
	#$t5 = number to look for
	#$t6 = current set
	
	li $v0, 4
	la $a0, intprompt
	syscall
	li $v0, 5
	syscall
	move $t5, $v0
	
	#0xaaaaaaaa
	move $t6, $t3
	li $v0, 4		#print first hex
	la $a0, hex1
	syscall
	jal printSet
	jal inSet
	
	#0x24924924
	move $t6, $t4
	li $v0, 4
	la $a0, hex2	#print second hex
	syscall
	jal printSet
	jal inSet
	
	li $v0, 4
	la $a0, newline
	syscall
	
	#Union
	li $v0, 4
	la $a0, unionStr
	syscall
	jal union
	jal printSet
		#end brace:
	
	#Intersection
	li $v0, 4
	la $a0, intersectStr
	syscall
	jal intersection
	jal printSet
	
	#end
	li $v0, 10
	syscall

printSet:
	li $t0, 1			#reset mask
	li $t2, 1			#reset count
	li $v0, 4
	la $a0, openBrace
	syscall
Loop:
	beq $t2, $t1, printSetReturn	#if count = whentostop, return
	and $t7, $t0, $t6	#AND mask and input
	beqz $t7, noOutput	#branch if mask = 0
	
	li $v0, 1	#Print count
	move $a0, $t2
	syscall		#Print space
	li $v0, 4
	la $a0, space
	syscall
noOutput: 
	addiu $t2, $t2, 1
	sll $t0, $t0, 1
	j Loop
printSetReturn:
	li $v0, 4
	la $a0, endBrace
	syscall
	la $a0, newline
	syscall
	jr $ra
##END printSet

inSet:
	li $t0, 1
	addi $t7, $t5, -1	#convert number to look for into offset
	sllv $t0, $t0, $t7	#move mask to position
	and $t8, $t0, $t6
	
	li $v0, 4
	beqz $t8, noIn
	
	la $a0, yesInSet
	j yesIn
noIn:
	la $a0, noInSet
yesIn:
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
	
union:
	or $t6, $t4, $t3
	jr $ra

intersection:
	and $t6, $t4, $t3
	jr $ra
