extends Camera 
export var lerp_speed = 10.0
export(NodePath) var PlayerPath 
var target = null

func _ready() -> void:
	target = get_node(PlayerPath)


func _physics_process(delta):
	if !target:
		return
	var pos:Transform = target.global_transform
	 
	global_transform = global_transform.interpolate_with(pos, lerp_speed * delta)
	
	
	
func _on_change_camera(t):
	target = t


func _on_Player_change_camera(t) -> void:
	target = t
