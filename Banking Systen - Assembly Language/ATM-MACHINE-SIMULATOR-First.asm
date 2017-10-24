#Project:
#ATM machine’s simulator in Assembly Language. The project is consist three main functions. Withdraw, Deposit and Balance.

#Work:
	#Programming: Rizwan Ali Shah (cs141029), Hammad Mehboob (cs141080)
	#Assistance/Help: Sir Areeb Moin
	
.data
	#####INTRO SCREEN
	intro: .asciiz "\t\t----------------------------------------"
	intro1: .asciiz "\n\t\t*\t     WELCOME                *\n                       *   TO THE ALLIED BANK ATM MACHINE     *"
	intro2: .asciiz "\n\t\t----------------------------------------"
	#####INTRO SCREEN END

	#####4 DITGIT PIN CODES AKA SAMPLE PIN CODES
	#Some pin codes

	pin1: .word 1234	

	#####END SAMPLE PINS

	#####EXPRESSOINS#####
	exp1: .asciiz "\n\n\nEnter your 4-DIGIT PIN CODE :"

	#####END EXPRESSIONS#####

	#####ATM MENU#####
	withdrawExpression:    .asciiz "\n\n\t\t|*******Press '1' to Withdraw*******|\n"
	depositExpression:     .asciiz "\t\t|*******Press '2' to Deposit********|\n"
	viewAmountExpression:  .asciiz "\t\t|*******Press '3' to View Balance***|\n"
	fastCashExpression:    .asciiz "\t\t|*******Press '4' for Fast Cash*****|\n\n"
	askUserExpression:     .asciiz "\nEnter Your Choice>>:  "
	#####ATM MENU ENDS#####
	
	####EXPRESSIONS FOR FUNCTIONS########
	#WITHDRAW
	var_1: .asciiz "\n\n\t\t*-----Welcome To Withdraw Section----*"
	var_2: .asciiz "\n\nHow much money you want to Withdraw>>: "
	
	#DEPOSIT
	var_3: .asciiz "\n\n\t\t*-----Welcome To Deposit Section-----*"
	var_4: .asciiz "\n\nHow much money you want to Deposit: "
	
	#VIEW_AMOUNT
	var_5: .asciiz "\n\n\t\t*-----Welcome To View Balance Section-----*"
	var_6: .asciiz "\n\nYour Total Account Balance is : "
	
	#FAST_CAST
	var_7: .asciiz "\n\n\t\t*-----Welcome To Fast Cash Section-----*\n\n"
	var_9: .asciiz "\n1) 1000\t2) 1,500\n3) 2,000\t4) 5,000\n5) 10,000\t6) 15,000\n" 
	var_8: .asciiz "\nSelect Any One Of The Option given above: "
	
	#WITHDRAWN FROM FAST_CASH
	Exp_1: .asciiz "Congratulation! You have successfully withdrawn Rs: 1000\n"
	Exp_2: .asciiz "Congratulation! You have successfully withdrawn Rs: 1500\n"
	Exp_3: .asciiz "Congratulation! You have successfully withdrawn Rs: 2000\n"
	Exp_4: .asciiz "Congratulation! You have successfully withdrawn Rs: 5000\n"
	Exp_5: .asciiz "Congratulation! You have successfully withdrawn Rs: 10,000\n"
	Exp_7: .asciiz "Congratulation! You have successfully withdrawn Rs: 15,000\n"
	Exp_6: .asciiz "\n\nYour remaining amount is: "
	
	
	#totalBalance
	Total_Balance: .word 50000


	#variables for Fast_Cash amount
	one_thousand: .word 1000
	Fifteen_Hundred: .word 1500
	TwoThousand: .word 2000
	FiveThousand: .word 5000
	TenThousand: .word 10000
	FifteenThousand: .word 15000
	
	#WithdrawnExpression
	WithdrawnAmount: .asciiz "\nYou've withdrawn: "
	
	 Exp_Invalid: .asciiz "\n\nYour Enterd Amount is insufficient."
	 
	 Deposit_Amount: .asciiz "\n\nYour Entered Amount has been deposited"
	 Final_Deposit_Amount: .asciiz "\nYour Amount After Depositing is : "
	 
	 
	 #CREDITS&THANKSVARIABLES :D
	thankYou: .asciiz "\n\n\t\t*-----Thank you for using our ATM service-----*\n"	
	inst:	.asciiz "\n\n\tInstructor/Helper: Sir Areeb Moin\n\n"
	credit:	.asciiz "\n\t This Program is designed and developed by:\n\n\t Rizwan Ali Shah(CS-141-029)\n\t Hammad Mehboob(CS-141-080)\n\n"
	
	
	
	
.text
.globl main
main:
	
#####INTRO SCREEN HERE :D ############

	#Print Intro
	li $v0, 4
	la $a0, intro
	syscall
	
	#Print Intro1
	li $v0, 4
	la $a0, intro1
	syscall
	
	#Print Intro2
	li $v0, 4
	la $a0, intro2
	syscall


######INTRO SCREEN ENDS HERE :D ############

######ASKING FOR USER's 4-Bit PIN ##########
	
	#printing Exp1
	li $v0, 4
	la $a0, exp1
	syscall

	#user input here
	li $v0, 5
	syscall

	#moving input from $v0 to $t0 (for later use)	
	move $t0, $v0
	
	#setting up the PIN
	lw $t1, pin1 

	#if the PIN IS valid
	beq $t1, $t0, ValidUser
	
	#end program
	li $v0, 10
	syscall
	
ValidUser:
	
	#Print the ATM MENU
	
	#printing Widthdraw
	li $v0, 4
	la $a0, withdrawExpression
	syscall
	
	#printing deposit
	li $v0, 4
	la $a0, depositExpression
	syscall

	#printing view amount
	li $v0, 4
	la $a0, viewAmountExpression
	syscall
	
	#printing fastCase
	li $v0, 4
	la $a0, fastCashExpression
	syscall
	#ATM MENU ENDS
	
	#printint askUser's Input
	li $v0, 4
	la $a0, askUserExpression
	syscall
	
	#using input for chossing function
	li $v0, 5
	syscall
	
	#moving input form $v0 to $t2
	move $t2, $v0
	
	######JUMPING TO FUCNTIONS ACCORIND TO USER's INPUT HERE
	#take user input and compare it with the respective function(input) like 1 for withdraw and stuff like that
	#for withdraw
	beq $t2, 1, withdraw
	
	#for deposit
	beq $t2, 2, deposit
	
	#for view amount
	beq $t2, 3, viewAmount
	
	#for fastCase
	beq $t2, 4, fastCash
	######JUMPING TO FUNCITONS ACCORDING TO USER'S INPUT ENDS HERE###########	

	#end program
	li $v0, 10
	syscall
	
withdraw:

	#setting total amount
	lw $v0, Total_Balance
	
	#moving v0 to t4
	move $t4, $v0
	
	
	###PRINTING EXPRESSIONS FOR WITHDRAW#####
	li $v0, 4
	la $a0, var_1
	syscall
	
	li $v0, 4
	la $a0, var_2
	syscall
	####PRINTING EXPRESSION FOR WITHDRAW ENDS HERE#####
	
	#input form user:
	li $v0, 5
	syscall
	
	#moving from v0 to t3
	move $t3, $v0
	
	#if user's input amount is greater then actual total amount
	bgt $t3, $t4, Invalid_Amount
	
	#if user's input amount is lesser then actual total amount then withdraw
	ble $t3, $t4, Valid_Amount
	
	#end program
	li $v0, 10
	syscall

Invalid_Amount:
	#Print Invalid Amount Message on the Screen :D
	li $v0, 4
	la $a0, Exp_Invalid
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end System
	li $v0, 10
	syscall
	
Valid_Amount:
	#Print How much is withdrawn
	#print Expression
	li $v0, 4
	la $a0, WithdrawnAmount
	syscall
	
	#printSum
	li $v0, 1
	move $a0, $t3
	syscall
	
	#print remaing amount
	sub $t3,$t4,$t3
	
	#print expression
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print sum
	li $v0, 1
	move $a0, $t3
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end system
	li $v0, 10
	syscall
	
deposit:
	
	###PRINTING EXPRESSIONS FOR DEPOSIT#####
	li $v0, 4
	la $a0, var_3
	syscall
	
	li $v0, 4
	la $a0, var_4
	syscall
	####PRINTING EXPRESSION FOR DEPOSIT ENDS HERE#####
	
	#setting up the total amount
	lw $t5, Total_Balance
	
	#taking input for deposit
	li $v0, 5
	syscall
	
	#moving inpur from v0 to t4
	move $t4, $v0
	
	add $t4,$t4,$t5
	
	#print Varification
	li $v0, 4
	la $a0, Deposit_Amount
	syscall
	
	#print total Sum
	li $v0, 4
	la $a0, Final_Deposit_Amount
	syscall
	
	#print sum ACTUAL
	li $v0, 1
	move $a0, $t4
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	
	#end program
	li $v0, 10
	syscall
	
viewAmount:

	###PRINTING EXPRESSIONS FOR ViewAmount#####
	li $v0, 4
	la $a0, var_5
	syscall
	
	li $v0, 4
	la $a0, var_6
	syscall
	####PRINTING EXPRESSION FOR ViewAmount ENDS HERE#####
	
	#setting up total balance
	lw $t6, Total_Balance
	
	#print total
	li $v0, 1
	move $a0, $t6
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	
	#end program
	li $v0, 10
	syscall
	
fastCash:

	###PRINTING EXPRESSIONS FOR FastCast#####	
	li $v0, 4
	la $a0, var_7
	syscall	
	
	li $v0, 4
	la $a0, var_9
	syscall

	li $v0, 4
	la $a0, var_8
	syscall

	####PRINTING EXPRESSION FOR fastCash ENDS HERE#####

	#taking user choice as an input
	li $v0, 5
	syscall
	
	#moving the inputfrom $v0, $t3
	move $t3, $v0
	
	#comparing the selcted input with the FAST CASH display!
	beq $t3, 1, Thousand
	beq $t3, 2, FifteenHundred
	beq $t3, 3, Two_Thousand
	beq $t3, 4, Five_Thousand
	beq $t3, 5, Ten_Thousand
	beq $t3, 6, Fiften_Thousand	 
	
	#end program
	li $v0, 10
	syscall

Thousand:
	#Printing The Varification of Withdrawn Amount
	li $v0, 4
	la $a0, Exp_1
	syscall
	
	#sending total amount to register
	lw $v0, Total_Balance
	
	#moving balance from $v0 to $t4
	move $t5, $v0
	
	#setting the constant
	lw $v0, one_thousand
	move $t6, $v0
	
	#subtracting withdrawn amount from total amount
	sub $t5, $t5, $t6
	
	#printing Exp to print the total amount
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print total Amount
	li $v0, 1
	move $a0, $t5
	syscall 
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	
	#end program
	li $v0, 10
	syscall

FifteenHundred:
	#Printing The Varification of Withdrawn Amount
	li $v0, 4
	la $a0, Exp_2
	syscall
	
	#sending total amount to register
	lw $v0, Total_Balance
	
	#moving balance from $v0 to $t4
	move $t5, $v0
	
	#setting the constant
	lw $v0, Fifteen_Hundred
	move $t6, $v0
	
	#subtracting withdrawn amount from total amount
	sub $t5, $t5, $t6
	
	#printing Exp to print the total amount
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print total Amount
	li $v0, 1
	move $a0, $t5
	syscall 
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end program
	li $v0, 10
	syscall

Two_Thousand:
	#Printing The Varification of Withdrawn Amount
	li $v0, 4
	la $a0, Exp_3
	syscall

	#sending total amount to register
	lw $v0, Total_Balance
	
	#moving balance from $v0 to $t4
	move $t5, $v0
	
	#setting the constant
	lw $v0, TwoThousand
	move $t6, $v0
	
	#subtracting withdrawn amount from total amount
	sub $t5, $t5, $t6
	
	#printing Exp to print the total amount
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print total Amount
	li $v0, 1
	move $a0, $t5
	syscall 
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end program
	li $v0, 10
	syscall

Five_Thousand:
	#Printing The Varification of Withdrawn Amount
	li $v0, 4
	la $a0, Exp_4
	syscall

	#sending total amount to register
	lw $v0, Total_Balance
	
	#moving balance from $v0 to $t4
	move $t5, $v0
	
	#setting the constant
	lw $v0, FiveThousand
	move $t6, $v0
	
	#subtracting withdrawn amount from total amount
	sub $t5, $t5, $t6
	
	#printing Exp to print the total amount
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print total Amount
	li $v0, 1
	move $a0, $t5
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end program
	li $v0, 10
	syscall

Ten_Thousand:
	#Printing The Varification of Withdrawn Amount
	li $v0, 4
	la $a0, Exp_5
	syscall

	#sending total amount to register
	lw $v0, Total_Balance
	
	#moving balance from $v0 to $t4
	move $t5, $v0
	
	#setting the constant
	lw $v0, TenThousand
	move $t6, $v0
	
	#subtracting withdrawn amount from total amount
	sub $t5, $t5, $t6
	
	#printing Exp to print the total amount
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print total Amount
	li $v0, 1
	move $a0, $t5
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end program
	li $v0, 10
	syscall

Fiften_Thousand:
	#Printing The Varification of Withdrawn Amount
	li $v0, 4
	la $a0, Exp_7
	syscall

	#sending total amount to register
	lw $v0, Total_Balance
	
	#moving balance from $v0 to $t4
	move $t5, $v0
	
	#setting the constant
	lw $v0, FifteenThousand
	move $t6, $v0
	
	#subtracting withdrawn amount from total amount
	sub $t5, $t5, $t6
	
	#printing Exp to print the total amount
	li $v0, 4
	la $a0, Exp_6
	syscall
	
	#print total Amount
	li $v0, 1
	move $a0, $t5
	syscall
	
	#Closing Message
	li $v0, 4
	la $a0, thankYou
	syscall

	#Print Instructor Name
	li $v0, 4
	la $a0, inst
	syscall

	#print Developers Names
	li $v0, 4
	la $a0,credit
	syscall
	
	#end program
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	