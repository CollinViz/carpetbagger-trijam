extends "res://BaseGameBody.gd"


export var Active:=true
export var startShootingTimer:=0.1
export var ShootingCoolDownCycle:=4
export var ShootingCoolDownWaitCycle:=2


var dir :=Vector3.ZERO
var vel :=Vector3.ZERO
var speed:=30
var isShooting:=false
var cnt:=0

onready var PlayerModel :=$Playermod
onready var Fire_CoolDown :Timer =$fire_cooldown
onready var bullet :=preload("res://bullits/bullet1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Point=-1
	add_to_group("player")

func _physics_process(delta) ->void:
	dir = Vector3(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
					Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"),
					0.0).normalized()
	vel = lerp(vel,dir * speed,0.05) # was 30

	rotation_degrees.z = vel.x * -2.0
	rotation_degrees.x = vel.y / 1.5
	rotation_degrees.y = vel.x * 1.5

	var col = move_and_collide(vel * delta)
	if col:
		print("You hit something")


	global_transform.origin.x = clamp(global_transform.origin.x,-20,20)
	global_transform.origin.y = clamp(global_transform.origin.y,-15,15)

	if Input.is_action_just_pressed("ui_accept"):
		startShooting()
	
	if Input.is_action_just_released("ui_accept"):
		isShooting = false



func startShooting():
	isShooting = true
	Fire_CoolDown.stop()
	
	startShootingTimer = PlayerModel.startShootingTimer
	ShootingCoolDownCycle = PlayerModel.ShootingCoolDownCycle
	ShootingCoolDownWaitCycle = PlayerModel.ShootingCoolDownWaitCycle

	Fire_CoolDown.start(startShootingTimer)
	_on_fire_cooldown_timeout()




func _on_fire_cooldown_timeout() -> void:
	if isShooting == false:
		Fire_CoolDown.stop()
		return
	if cnt<ShootingCoolDownCycle:
		Fire_CoolDown.wait_time = ShootingCoolDownWaitCycle
	
	if cnt == ShootingCoolDownCycle:
		cnt=0
		Fire_CoolDown.wait_time = 0.5

	cnt+=1
	
	var b= bullet.instance()
	b.collision_layer = self.collision_layer
	b.collision_mask = self.collision_mask
	b.speed = -10
	get_parent().add_child(b)
	b.global_transform.origin = PlayerModel.getNextBuilitStartPostion()




