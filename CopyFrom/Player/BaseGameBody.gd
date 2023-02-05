extends KinematicBody

export var HP:=2
export var MaxHP:=4
export var Point:=1

onready var explotion := preload("res://fx/Explode.tscn")

func TakeDamage(Amount:int,_from:Node) -> void:
	HP-=Amount
	if HP<=0:
		doExpotion()

func updateScore():
	if Point>0:
		GameSystem.call_deferred("Score_Up",Point)


func doExpotion()->void:
	var b = explotion.instance()
	get_parent().add_child(b)
	b.global_transform.origin = self.global_transform.origin
	updateScore()
	call_deferred("queue_free")
