extends Spatial

onready var partical:CPUParticles = $CPUParticles


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func start_particals():
	partical.emitting = true
