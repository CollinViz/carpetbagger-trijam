extends Area


export(NodePath) var LookAt 
export(NodePath) var TranformNode 

var target:Spatial = null
var fromtarget:Spatial = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = null
	fromtarget = null


func _physics_process(delta: float) -> void:
	if target==null || fromtarget==null:
		return
		
	fromtarget.look_at(target.global_translation,Vector3.UP)

func _on_LookAtMe_body_entered(body: Node) -> void:
	target = get_node_or_null(LookAt)
	fromtarget = get_node_or_null(TranformNode)


func _on_LookAtMe_body_exited(body: Node) -> void:
	if fromtarget!=null:
		fromtarget.look_at(Vector3.ZERO,Vector3.UP)
	target=null
	fromtarget=null


func _on_LookAtMe_area_entered(area: Area) -> void:
	target = get_node_or_null(LookAt)
	fromtarget = get_node_or_null(TranformNode)


func _on_LookAtMe_area_exited(area: Area) -> void:
	if fromtarget!=null:
		fromtarget.look_at(Vector3.ZERO,Vector3.UP)
	target=null
	fromtarget=null
