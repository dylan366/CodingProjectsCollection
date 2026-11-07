.text
.globl main

main:
	# Input number 1 and move to $t0
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	# Input number 2 and move to $t1
	li $v0, 5 #unnecessary line because 5 is still there from line 6
	syscall
	
	move $t1, $v0
	
	# Add number 1 and 2 together and store in $t2
	add $t2, $t0, $t1
	
	# Move $t2 to $a0 and set $v0=1 for printing
	move $a0, $t2
	li $v0, 1
	syscall
	
	# Exit program
	li $v0, 10
	syscall
	
	