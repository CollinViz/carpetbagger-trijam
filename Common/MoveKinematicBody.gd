extends Spatial


export(float) var ArriveDistance = 1
export(NodePath) var StatsPath
export(NodePath) var MoveObjectPath
export(NodePath) var ObjectMeshPath
export(NodePath) var NaveAgentPath
signal on_finished_moving
signal target_reached

onready var MoveBody:Spatial = get_node_or_null(MoveObjectPath)
onready var ObjectMesh:Spatial = get_node_or_null(ObjectMeshPath)
onready var NavAgen:NavigationAgent = get_node_or_null(NaveAgentPath)
onready var Stats:StatsSystem = get_node_or_null(StatsPath)
var path = []
var path_index = 9999
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if NavAgen==null:
		return
	
	NavAgen.connect("navigation_finished",self,"navigation_finished")
	NavAgen.connect("target_reached",self,"target_reached")
	
func navigation_finished():
	emit_signal("on_finished_moving")
	
func target_reached():
	emit_signal("target_reached")
	
func _physics_process(delta):
	if path == null || MoveBody ==null || NavAgen==null:
		return
	
	if !NavAgen.is_navigation_finished():
		var pos = NavAgen.get_next_location()
		var dir = (pos - MoveBody.global_transform.origin)
		if dir.length() < ArriveDistance:
			NavAgen.set_target_location(MoveBody.global_transform.origin)
			emit_signal("on_finished_moving")
		else:
			MoveBody.move_and_slide_with_snap(dir.normalized() * Stats.Base_speed * delta,Vector3.DOWN,Vector3.UP)
			if ObjectMesh !=null:
				ObjectMesh.look_at(pos, Vector3.UP)
				ObjectMesh.rotation.x = 0
				ObjectMesh.rotation.z = 0
		 

func start_move(new_path:Array):
	path = new_path
	path_index = 0

	
func reset():
	path = []
	path_index = 0
	
func has_finished_path():
	if path == null:
		return true
		
	return path_index >= path.size()
