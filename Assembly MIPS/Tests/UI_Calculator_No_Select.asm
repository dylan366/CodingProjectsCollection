.data
plus: .asciiz " + "
minus: .asciiz " - "
multiply: .asciiz " * "
divide: .asciiz " / "
remainder: .asciiz " with remainder: "
equals: .asciiz " = "
newline: .asciiz "\n"
userinput1: .asciiz "User Input 1: "
userinput2: .asciiz "User Input 2: "
Askinput1: .asciiz "Input First Number: "
Askinput2: .asciiz "Input Second Number: "

.text
.globl main

main:
	# Ask user for two numbers and store in $t0 and $t1
	jal Ask_Input1
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	jal Ask_Input2
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	jal print_Inputs
	
	# Make sure $t0 is greater or equal than $t1
	bgt $t1, $t0, switch_AB
	
	j continue_main1
	

switch_AB:
	move $a0, $t0
	move $t0, $t1
	move $t1, $a0
	j continue_main1

continue_main1:
	# Add and store in $t2
	add $t2, $t0, $t1
	
	# sub and store in $t3
	sub $t3, $t0, $t1
	
	# multiply A with B into $t4
	mul $t4, $t0, $t1
	
	# divide A with B into lO and move quotient to $t5 and remainder to $t6
	div $t0, $t1 
	mflo $t5
	mfhi $t6
	
	# Print solution of addition as " {A} {+} {B} {equals} {C}\n"
	jal print_inputA
	
	li $v0, 4
	la $a0, plus
	syscall
	
	jal print_inputB
	
	jal print_equals
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	jal print_newline
	
	# Print solution of subtraction as " {A} {-} {B} {equals} {C}\n"
	jal print_inputA
	
	li $v0, 4
	la, $a0, minus
	syscall
	
	jal print_inputB
	
	jal print_equals
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	jal print_newline
	
	# Print solution of multiplication as " {A} {*} {B} {equals} {C}\n"
	jal print_inputA
	
	li $v0, 4
	la $a0, multiply
	syscall
	
	jal print_inputB
	
	jal print_equals
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	jal print_newline
	
	# Print solution and remainder of division as " {A} {/} {B} {equals} {C} {with remainder: } {D}\n"
	jal print_inputA
	
	li $v0, 4
	la $a0, divide
	syscall
	
	jal print_inputB
	
	jal print_equals
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, remainder
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall
	
	jal print_newline
	
	j exit_program

# Functions
Ask_Input1:
	li $v0, 4
	la $a0, Askinput1
	syscall
	jr $ra

Ask_Input2: 
	li $v0, 4
	la $a0, Askinput2
	syscall
	jr $ra
	
print_Inputs:
	# Print input A
	li $v0, 4
	la $a0, userinput1
	syscall 
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	move $s0, $ra #save leap address to main loop in s0
	jal print_newline
	
	# Print input B
	li $v0, 4
	la $a0, userinput2
	syscall 
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	jal print_newline
	move $ra, $s0
	
	jr $ra
	
print_newline:
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
	
print_inputA:
	li $v0, 1
	move $a0, $t0
	syscall
	jr $ra
	
print_inputB:
	li $v0, 1
	move $a0, $t1
	syscall
	jr $ra

print_equals:
	li $v0, 4
	la $a0, equals
	syscall
	jr $ra

exit_program:
	li $v0, 10
	syscall
	
