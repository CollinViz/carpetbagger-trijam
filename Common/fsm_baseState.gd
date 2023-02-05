extends Spatial

var PARENT:KinematicBody=null
var FSM
func exit_state(state):
	print("Exit State ",self.name)

func enter_state(state):
	print("Enter State ",self.name)
	
func update_state(state,_delta):
	pass
	#print("update State")
