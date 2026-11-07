.data
even_msg: .asciiz "Even\n"
odd_msg: .asciiz "Odd\n"

.text
.globl main

main: 
	la $s0, even_msg
	la $s1, odd_msg
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	andi $t1, $t0, 0x1 
	
	bne $t1, $zero, print_odd

print_even: 
	move $a0, $s0
	li $v0, 4
	syscall
	j exit
print_odd: 
	move $a0, $s1
	li $v0, 4
	syscall
	j exit
	
exit: 
	li $v0, 10
	syscall
	
	
	
	
