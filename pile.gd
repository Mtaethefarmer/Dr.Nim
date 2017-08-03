#ORGANS
#Displays number of items left in the pile
#When the label is clicked with the left mouse button subtract 1 from size
#Each organ shares this script
extends Label
var size
var turn

#Gives each pile a random amount of items from the start of the game
func _ready():
	randomize()
	size = (randi() % 50) + 1
	set_text(get_name() + " " + str(size))
	print("Player's turn.")

#Resets the player's turn after Dr.Nim done with his turn
#Player may resume selecting items from one pile
func playerTurnReset():
	for x in get_parent().get_children():
		x.set_ignore_mouse(false)
	get_node("/root/Node/UI/Accept").set_text("Accept")
	
	turn = get_node("/root/Node/UI/Accept").Turn 
	turn = 0
	print("Player's turn.")
	
#When the label is clicked with the left mouse button, subtract 1 from size
#Once the player selects the pile they cannot select another one
#Display changes
func _on_Pile_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT and ev.pressed):
		#print("Left mouse button was pressed on " + self.get_name())
		
		#Sets the first organ clicked to be the only selectable organ
		for x in get_parent().get_children():
			x.set_ignore_mouse(true)
		set_ignore_mouse(false)
		
		#Subtracts one from th organ clicked
		size -= 1
		set_text(get_name() + " " + str(size))
		
		#Resets to zero if clicked below zero
		if (size <= 0):
			size = 0
			set_text(get_name() + " " + str(size))

