#ACCEPT BUTTON
#Switches turns between player and DR.NIM
extends Label

enum Turn {PLAYER, COMPUTER}

func _ready():
	Turn = PLAYER

#Ends the player's turn after the button is clicked and switches to Dr.Nim's turn
func _on_Accept_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT and ev.pressed):
		print("Left mouse button was pressed on " + self.get_name())
		set_text("Turn Ended")
		Turn = COMPUTER
		print(str(Turn) + "'s Turn.")