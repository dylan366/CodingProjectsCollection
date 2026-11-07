# Tell program that this is the start of the code
.text
.globl main # main is a global recallable loop

main: 
	# Operation: (t1 * t2) + t0
	li $t0, 10 # store number 10 in t0
	li $t1, 20 # store number 20 in t1
	li $t2, 30 # store number 30 in t2

	mul $t3, $t1, $t2 # multiply t1 and t2 and store the result in t3
	add $t4, $t3, $t0 # add t3 and t0 and store result in t4
	
	# Exit Program
	li $v0, 10
	syscall
