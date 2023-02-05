extends SpringArm
export var mouse_sensitivity := 0.05

var is_Mouse_look:=true


func _ready()->void:
	set_as_toplevel(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _input(event)->void:
	if event is InputEventMouseMotion && is_Mouse_look:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, -10.0)

		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)


func mouse_lock(lock):
	is_Mouse_look = lock
	if lock:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
