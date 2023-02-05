extends Node


export var GroupToFind:="Player"
export var MaxRandome:=Vector3(10,0,10)
export var MinRandome:=Vector3(-10,0,-10)
export(float,0.2,5) var lookTimer:=0.5

signal Next_Pos(NewPosition)

onready var TimerCheck:Timer = $Timer

var _rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	TimerCheck.one_shot=false
	TimerCheck.start(lookTimer)
	_rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	var allNodes = get_tree().get_nodes_in_group(GroupToFind)
	if allNodes.size()==0:
		return
		
	_rng.randomize()
	var x = _rng.randf_range(MinRandome.x, MaxRandome.x)
	var y = _rng.randf_range(MinRandome.y, MaxRandome.y)
	var z = _rng.randf_range(MinRandome.z, MaxRandome.z)
	var offset = allNodes[_rng.randi_range(0,allNodes.size()-1)]
	emit_signal("Next_Pos",Vector3(x+offset.transform.origin.x,y+offset.transform.origin.y,z+offset.transform.origin.z))
	
