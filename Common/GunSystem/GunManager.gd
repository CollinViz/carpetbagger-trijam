extends Spatial

export(float) var field_of_view = 60
export(int) var Amo:=1
export(int) var Clip:=1
export(float) var ReloadTime:=3

onready var rayCheck:RayCast = $RayCast
onready var _reLoadTimer:Timer = $reLoadTimer

signal reloading()
signal ready_fire()
signal shooting()

var skipTimerFrams=5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reLoadTimer.one_shot = true
	_reLoadTimer.connect("timeout",self,"can_ready_fire")

func get_max_range()->float:
	return 5.0

func _process(delta: float) -> void:
	skipTimerFrams-=1
	if skipTimerFrams<=0 && !_reLoadTimer.is_stopped():
		skipTimerFrams = 15 		
		LevelState.reload_uiUpdate("Reload %s" % str(_reLoadTimer.time_left).pad_decimals(1))


func can_ready_fire():
	emit_signal("ready_fire")

func is_target_inside_fov(target:Spatial):
	var pos = global_transform.origin
	var direction = global_transform.basis.z
	var target_pos = target.transform.origin
	rayCheck.cast_to = to_local(pos)
	rayCheck.force_raycast_update()
	if rayCheck.is_colliding() && rayCheck.get_collider()!=target:
		return false
	return is_inside_cone(pos, direction, target_pos)
	
func is_inside_cone(cone_tip, cone_normal:Vector3, point):
	var differenceVector:Vector3 = point - cone_tip
	differenceVector = differenceVector.normalized()

	# Dot product of 2 vectors => the cosine of the angle between them
	# Note: only when the vectors are normalized
	return cone_normal.dot(differenceVector) >= cos(deg2rad(field_of_view/2))


func shootAt(listToShootAt:Array,from:Spatial)->void:
	if _reLoadTimer.is_stopped() && Amo>0:
		print("Shooting")
		for t in listToShootAt:
			t.get_node("Stats").take_damage(1,[],from)
		Amo=Amo-1	
		emit_signal("shooting")
	if Amo<=0:
		do_reload()


func do_reload():
	_reLoadTimer.start(ReloadTime)
	Amo = Clip
	emit_signal("reloading")
	
