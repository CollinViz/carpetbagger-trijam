extends Spatial

class_name TargetSystem
export(NodePath) var SensorsManagerPath
export(float,0.3,5) var TimerCheck:=0.5

onready var SensorsManager = get_node_or_null(SensorsManagerPath)

signal Found_Target(Target)
signal Lost_Target()

var _active_target = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UpdateTargets.wait_time=TimerCheck
	$UpdateTargets.start(TimerCheck) 


func has_active_target():
	return !(_active_target==null) && is_instance_valid(_active_target)
	
func active_target():
	if is_instance_valid(_active_target):
		return _active_target
	return null


func _on_UpdateTargets_timeout() -> void:
	if SensorsManager == null:
		return
	var allTargets = SensorsManager.list_all_targets()
	var newTarget = null
	if allTargets.size()==1:
		newTarget = allTargets[0]
	
	var goldTarget = null
	var enemiyTarget = null
	for x in allTargets:
		if is_instance_valid(x) && x.is_in_group("Gold") && goldTarget==null:
			goldTarget = x
		if is_instance_valid(x) && x.is_in_group("Enemy") && enemiyTarget==null:
			enemiyTarget = x
	if goldTarget!=null && enemiyTarget==null:
		newTarget = goldTarget
	if enemiyTarget!=null:
		newTarget = enemiyTarget
		
	if newTarget!=_active_target && newTarget!=null:
		_active_target = newTarget
		emit_signal("Found_Target",_active_target)
	if newTarget==null && _active_target!=null:
		emit_signal("Lost_Target")
		_active_target=null
		
