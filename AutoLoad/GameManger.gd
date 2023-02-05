extends Node2D



onready var _bg: AudioStreamPlayer = $BG
onready var _box_gone: AudioStreamPlayer = $BoxGone
onready var _wons: AudioStreamPlayer = $wons
onready var _los: AudioStreamPlayer = $Los
onready var _stop_time: Timer = $BoxGone/StopTime


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func box_gone():
	if _stop_time.is_stopped():
		_stop_time.start()
		_box_gone.call_deferred("play")

func wone():
	_wons.call_deferred("play")
	
func los():
	_los.call_deferred("play")
