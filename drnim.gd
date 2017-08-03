#DR.NIM
#Contains AI for DR.NIM when it is time to take his turn
extends Node

var x 
var randOrgan
var turn


#Checks for parity(even or odd) among total bits in a number
func parity(var bits):
	#Rounds down to the nearest interger
	bits = int(floor(bits))
	if bits % 2 == 0:
		#Return true if even
		return true
	else:
		#Returns false if odd
		return false

# Takes in a decimal value (int) and returns the binary value (int)
func dec2bin(var decimal_value): 
	var binary_string = "" 
	var temp 
	var count = 7 # Checking up to 8 bits 
	
	while(count >= 0): 
		temp = decimal_value >> count 
		if(temp & 1): 
			binary_string = binary_string + "1"
		else: 
			binary_string = binary_string + "0"
		count -= 1
		
	#print(binary_string)
	return int(binary_string)

# Takes in a binary value (int) and returns the decimal value (int)
func bin2dec(var binary_value): 
    var decimal_value = 0
    var count = 0
    var temp 
  
    while(binary_value != 0): 
        temp = binary_value % 10
        binary_value /= 10
        decimal_value += temp * pow(2, count) 
        count += 1
  
    return decimal_value

func _ready():
	pass
	
#When Accept button is pressed Dr.Nim takes his turn using the makeMove()
#Display change
#Reset the player's turn
func _on_Accept_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT and ev.pressed):
		turn = get_node("/root/Node/UI/Accept").Turn 
		turn = 0
		print("Dr.Nim's turn.")
		
		#Dr.Nim takes his turn
		makeMove(get_node("/root/Node/Body").get_children())
		
		#Player can take his turn after Dr.Nim takes his turn
		get_node("/root/Node/Body").get_child(0).playerTurnReset()
		
#Nimsum = Binary digital sum of the heap sizes, that is, the sum (in binary) neglecting all carries from one digit to another
#'^' is the excusive or symbol used for coverting numbers to binary and getting the nimsum as an interger
#Returns the nimsum of a group of numbers i.e if you have piles A[24],B[8], & C[17]
#A[24] = 11000
#B[8] =  01000
#C[19] = 10011
#A⊕B⊕C = '00011' or the nimsum of A,B and C is '3'
func nimSum(var myArray):
	var nimsum = myArray[0].size;
	for x in range(1,myArray.size()):
		nimsum = nimsum ^ myArray[x].size;
	return nimsum;

#Dr.Nim currently only has the winning strategy!
#Find a heap where the nim-sum of X and heap-size is less than the heap-size 
#A ⊕ X = 3 ⊕ 2 = 1 **Reduce heap A to 1**
#B ⊕ X = 4 ⊕ 2 = 6
#C ⊕ X = 5 ⊕ 2 = 7
func makeMove(var myArray):
	#Finds the nimsum of an array of numbers and stores it as 'ns'
	var ns = nimSum(myArray)
	print("The current nimsum is: " + str(ns))
	
	#As long as the nimsum of myArray is not 0 iterate through each organ,
	#If the nimsum of the size of myArray and ns is less than the size of myArray then,
	#set that pile's size equal to the nimsum of it's size and ns
	#'^' is the excusive or symbol used for coverting numbers to binary and getting the nimsum as an interger
	if ns != 0:
		for x in range(myArray.size()):
			if myArray[x].size ^ ns < myArray[x].size:
				print(myArray[x].get_name() + " will be shifted to " + str(myArray[x].size ^ ns))
				#If that arra
				if myArray[x].size == 0:
					myArray[x].size = 0
				else:
					myArray[x].size = myArray[x].size ^ ns
					print("SAFE")
				myArray[x].set_text(myArray[x].get_name() + " " + str(myArray[x].size))
				return myArray[x].size
				break;
				
	#If the ns is already equal to 0 then randomly pick a organ to take 1 from
	else:
		randomize()
		var organCount = randi() % get_node("/root/Node/Body").get_child_count()
		var randOrgan = get_node("/root/Node/Body").get_child(organCount)
		
		if randOrgan.size == 0:
			randOrgan.size = 0
		else:
			randOrgan.size -= 1
			print("UNSAFE")