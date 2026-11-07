.text
.globl main

main: 
	# User Input stored in $t0
	li $v0, 5
	syscall
	
	# allocate user input to return register
	move $t0, $v0
	
	# move Input to temporary register to print syscall
	move $a0, $t0
	li $v0, 1
	syscall
	
	# Exit program
	li $v0, 10
	syscall
	
	