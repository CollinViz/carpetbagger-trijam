extends Spatial

export var startShootingTimer:=0.1
export var ShootingCoolDownCycle:=4
export var ShootingCoolDownWaitCycle:=2

onready var builit1 = $BuilitArray/builit1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func getNextBuilitStartPostion()->Vector3:
	return builit1.global_transform.origin


func _on_fire_cooldown_timeout() -> void:
	pass # Replace with function body.
