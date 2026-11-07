.data
ProgramStart: .asciiz "This program outputs all real zeros to a quadratic polynomial in the form ax^2 + bx + c = 0 where a != 0 . Please enter a, b and c accordingly."
NewLine: .asciiz "\n"
EnterInputa: .asciiz "Enter Parameter a: "
EnterInputb: .asciiz "Enter Parameter b: "
EnterInputc: .asciiz "Enter Parameter c: "
OneSolutionMsg: .asciiz "The polynomial has 1 real solution. "
TwoSolutionsMsg: .asciiz "The polyonmial has 2 real solutions. "
TwoComplexSolutionsMsg: .asciiz "The polynomial has 2 complex solutions."
ImaginaryUnit: .asciiz "i "
PlusOperand: .asciiz " + "
MinusOperand: .asciiz " - "
ZeroPrint: .asciiz "x = "
Zero1Print: .asciiz "x1 = "
Zero2Print: .asciiz "x2 = "
CZero1Print: .asciiz "z1 = "
CZero2Print: .asciiz "z2 = "
aIsZeroErrorMsg: .asciiz "Input a cannot be zero!"
discriminantBelowZeroErrorMsg: .asciiz "Discriminant is below zero. Calculating imaginary solutions."

zero: .float 0
four: .float 4.0

.text
.globl main

main:
	jal OnBegin # Print welcome string and syntax instructions
	jal PrintNewLine
	jal FetchInputa # in $f1
	jal FetchInputb # in $f2
	jal FetchInputc # in $f3
	
	# Throw error if a=0
	lwc1 $f31, zero
	c.eq.s $f1, $f31
	bc1t aIsZeroError	
	
	# CALCULATE x_1,2 = (-b+-sqrt(b^2 -4ac) ) / 2a
	# calculate b^2 and store in $f4 (assuming b <= 1 byte)
	mul.s $f4, $f2, $f2
	
	# Calculate 4ac
	lwc1 $f30, four # store 4.0 in $f30
	mul.s $f5, $f1, $f3 # multiply a and c and set into $f5
	mul.s $f6, $f5, $f30 # mutliply previous by 4.0 into $f6
	
	# Calculate b^2 - 4ac into $f7 DISCRIMINANT
	sub.s $f7, $f4, $f6
	
	# Calculate 2a for denominator into $f9
	add.s $f9, $f1, $f1
	
	# Calculate -b into $f9
	neg.s $f10, $f2
	
	# Calculate -b / 2a into $f11
	div.s $f11, $f10, $f9
	
	# If b^2 - 4ac < 0 then the solutions will be imaginary, for now branch to error msg then exit
	# all other operations are done except ones related to the square root
	c.lt.s $f7, $f31
	bc1t discriminantBelowZeroError
	
	# Calculate sqrt(b^2 - 4ac) of discriminant in $f7 as real solution and store in $f8
	sqrt.s $f8, $f7
	
	# Calculate sqrt()/2a into $f13
	div.s $f13, $f8, $f9
	
	# All necessary calculations done. Now only +- sqrt needed depending on the number of solutions
	# Branch to check if one solution or two solutions
	# If discriminant = 0 -> 1 solution (branch), if discriminant != 0 -> two solutions (continue)
	c.eq.s $f7, $f31
	bc1t OneRealSolution
	
	# This part outputs the two real solutions.
	# + sqrt/2a in $f14
	add.s $f14, $f11, $f13
	# - sqrt/2a in $f15
	sub.s $f15, $f11, $f13
	
	# $f14 and $f15 contain the two real solutions
	li $v0, 4
	la $a0, TwoSolutionsMsg
	syscall
	jal PrintNewLine
	li $v0, 4
	la $a0, Zero1Print
	syscall
	li $v0, 2
	mov.s $f12, $f14
	syscall # print solution 1
	jal PrintNewLine
	li $v0, 4
	la $a0, Zero2Print
	syscall
	li $v0, 2
	mov.s $f12, $f15
	syscall #print solution 2

	j Exit

OneRealSolution:
	# Sqrt = 0, therefore the solution x = -b/2a which is already in $f11
	# Print message
	li $v0, 4
	la $a0, OneSolutionMsg
	syscall
	jal PrintNewLine
	# print zero msg
	li $v0, 4
	la $a0, ZeroPrint
	syscall
	# print the zero at $f11
	li $v0, 2
	mov.s $f12, $f11
	syscall
		
	j Exit	
	
discriminantBelowZeroError:
	li $v0, 4
	la $a0, discriminantBelowZeroErrorMsg
	syscall
	jal ImaginarySolutions
	
ImaginarySolutions:
	# -b/2a in $f11, b^2-4ac in $f7, 2a in $f9, $f8 and $f13+ are empty
	# negate discriminant and store in $f13
	neg.s $f13, $f7
	# sqrt negated discriminant in $f8
	sqrt.s $f8, $f13
	# sqrt()/2a in $f14 real parameters for i
	div.s $f0, $f8, $f9 
	mov.s $f14, $f0
	# solutions in form -b/2a + sqrt(negD)/2a i and -b/2a - sqrt(negD)/2a i
	li $v0, 4
	la $a0, TwoComplexSolutionsMsg
	syscall
	jal PrintNewLine
	# Print plus solution
	li $v0, 4
	la $a0, CZero1Print
	syscall
	li $v0, 2
	mov.s $f12, $f11 
	syscall
	jal PrintPlus
	li $v0, 2
	mov.s $f12, $f14
	syscall
	jal PrintImaginaryUnit
	jal PrintNewLine
	# Print Minus Solution
	li $v0, 4
	la $a0, CZero2Print
	syscall
	li $v0, 2
	mov.s $f12, $f11 
	syscall
	jal PrintMinus
	li $v0, 2
	mov.s $f12, $f14
	syscall
	jal PrintImaginaryUnit	
	
	j Exit
	
	

	
OnBegin:
	li $v0, 4 # Print Prgram start message
	la $a0, ProgramStart
	syscall
	jr $ra

PrintNewLine: 
	li $v0, 4 # Print line break
	la $a0, NewLine 
	syscall
	jr $ra

PrintPlus:
	li $v0, 4
	la $a0, PlusOperand
	syscall
	jr $ra
	
PrintMinus:
	li $v0, 4
	la $a0, MinusOperand
	syscall
	jr $ra

PrintImaginaryUnit:
	li $v0, 4
	la $a0, ImaginaryUnit
	syscall 
	jr $ra

FetchInputa: 
	li $v0, 4 # Print Enter First parameter
	la $a0, EnterInputa 
	syscall
	li $v0, 6 # Let user input a and store in $f1
	syscall
	mov.s $f1, $f0  
	jr $ra
	
FetchInputb: 
	li $v0, 4 # Print Enter Second parameter
	la $a0, EnterInputb 
	syscall
	li $v0, 6 # Let user input b and store in $f2 
	syscall
	mov.s $f2, $f0
	jr $ra

FetchInputc: 
	li $v0, 4 # Print Enter Third parameter
	la $a0, EnterInputc
	syscall
	li $v0, 6 # Let user input c and store in $f3
	syscall
	mov.s $f3, $f0
	jr $ra
	
aIsZeroError: # Print error and exit program if a is zero (Change later that user can re-enter a)
	li $v0, 4
	la $a0, aIsZeroErrorMsg
	syscall
	j Exit
	
Exit: # exit program unconditionally
	li $v0, 10
	syscall
