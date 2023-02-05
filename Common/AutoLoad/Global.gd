extends Spatial


const FS_IS_ENABLED ="is_enabled"
const FS_IS_MOVING ="is_moving"
const FS_ARIVED ="has_arived"
const FS_HAS_TARGET ="has_target"
const FS_IS_DOGROLL ="is_dogroll" 
const FS_SHOULD_REAREAT ="should_retreat"
const FS_TARGET_IN_RANGE ="target_in_range"
const FS_NO_TARGET ="no_target"
const FS_IS_ATTACKING ="is_attacking"
const FS_IS_DEAD ="is_dead"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func get_StateHead(State:String):
	var s = State.split('/')
	return s[0]

func get_StateLast(State:String):
	var s = State.split('/')
	return s[s.size()-1]
