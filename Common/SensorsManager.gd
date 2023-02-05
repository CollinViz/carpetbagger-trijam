extends Spatial

class_name SensorsManager
 
export(float,0.3,5) var UpdateTimer setget updateTimerClock

onready var UpdateSensore:Timer = $UpdateSensors
var target_old=[]
var all_targets=[]
var bFilterTargetByFOV :=false
var fov_Sensore=null
func updateTimerClock(newValue):
	if UpdateSensore !=null:
		UpdateTimer = newValue
		UpdateSensore.wait_time = newValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateSensore.wait_time = UpdateTimer
	UpdateSensore.one_shot =true
	UpdateSensore.start(UpdateTimer)
	for c in get_children():
		if c is FovDetector:
			bFilterTargetByFOV = true
			fov_Sensore = c


func _process(_delta):
	global_transform.origin = get_parent().global_transform.origin

func _physics_process(delta: float) -> void:
	if UpdateSensore.is_stopped():
		update_targets()
		UpdateSensore.start(UpdateTimer)

func update_targets():
	 
	var target_unsorted =[]
	for c in get_children():
		if c is RangeDetector:
			for x  in c.get_target_list():
				if is_instance_valid(x):
					x.set_meta("_distance_%s"%get_instance_id(), abs((self.global_transform.origin-x.global_transform.origin).length()))
					target_unsorted.append(x)
	
	if target_unsorted.size()>0 && all_targets && bFilterTargetByFOV:
		var filterList = []
		for t in target_unsorted:
			if is_instance_valid(t) && fov_Sensore.is_target_inside_fov(t):
				filterList.append(t)
		target_unsorted = filterList
	
	#order list based on distance
	if target_unsorted.size()>0:
		target_unsorted.sort_custom(self, "sortDistance")
	all_targets = target_unsorted
	 

func _on_UpdateSensors_timeout() -> void:
	pass
	
func sortDistanceDesc(a, b):
	if is_instance_valid(a) && is_instance_valid(b):
		if a.get_meta("_distance_%s"%get_instance_id())> b.get_meta("_distance_%s"%get_instance_id()):
			return true
	return false

func sortDistance(a, b):
	if is_instance_valid(a) && is_instance_valid(b):
		if a.get_meta("_distance_%s"%get_instance_id())< b.get_meta("_distance_%s"%get_instance_id()):
			return true
	return false
		
func list_all_targets()->Array:
	return all_targets
