extends Spatial


var isCapture:=true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.scancode==KEY_ESCAPE && event.pressed:
		print("Escape key pressed")
		isCapture=!isCapture
		get_tree().call_group("mouse_lock","mouse_lock",isCapture)
