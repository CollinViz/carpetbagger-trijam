tool
extends Path

class_name path_spawner

export(PackedScene) var ObjectSpawn:PackedScene = null
export var spawn:=false setget setSpawn
export(int,0,999) var NumberToSpawn
export(bool) var PathFollowItems:=false
export var speed_Sec:=0.0
export var Auto_spawn:=false
export var GroupCallONDead:=""
export(Array,String) var Arg:=[]


onready var Follow_track :PathFollow =$PathFollow
onready var remoteFollow:RemoteTransform = $PathFollow/RemoteTransform 
onready var item_list:Spatial = $items

var maxPathLength := 0.0
var forward:=true
var lock:=false
func setSpawn(newValue):
	if ObjectSpawn!=null:
		if curve.get_baked_length()>0:
			spawn_objects()
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxPathLength = curve.get_baked_length()
	if Auto_spawn:
		spawn_objects()


func spawn_objects():
	lock = false
	var item_node:Spatial = get_node_or_null("items")
	if item_node == null:
		return
	
	for c in item_node.get_children():
		c.queue_free()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")	
	var numPaths:PoolVector3Array = curve.get_baked_points()
	
	if numPaths.size()<NumberToSpawn:
		print("Need more points")
		return
	
	if NumberToSpawn>0:
		var numIdx = numPaths.size()/NumberToSpawn
		
		for x in NumberToSpawn:
			var c:Spatial = ObjectSpawn.instance()
			if x*numIdx>numPaths.size():
				c.translation = numPaths[numPaths.size()-1]
			else:
				c.translation = numPaths[x*numIdx]
				
			item_node.add_child(c)
			if PathFollowItems:
				remoteFollow.remote_path=c.get_path()
	lock = true

func bouce_pad_dead(args:Array):
	spawn_objects()


func _physics_process(delta: float) -> void:
	if Follow_track==null:
		return
	if !PathFollowItems:
		return
	if forward:
		if maxPathLength<=(Follow_track.offset+(speed_Sec) * delta):
			forward=false
		Follow_track.offset+= (speed_Sec) * delta
	else:
		if Follow_track.offset-(speed_Sec) * delta<=0:
			forward = true
		Follow_track.offset-= (speed_Sec) * delta 
	
	


func _on_items_child_exiting_tree(node: Node) -> void:
	if Engine.editor_hint:
		return 
		
	if lock==false:
		return 
	if item_list.get_child_count()<=1:
		if GroupCallONDead!="":
			Arg.insert(0,GroupCallONDead)
			get_tree().call_group(GroupCallONDead,"bouce_pad_dead",Arg)
	
