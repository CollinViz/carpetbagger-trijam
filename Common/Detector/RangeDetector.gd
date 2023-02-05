extends Spatial

class_name RangeDetector

export var radius:=5.0
export var Hieght:=1.0
export(int, LAYERS_3D_PHYSICS) var LayerUsed
export(int, LAYERS_3D_PHYSICS) var MaskUsed

signal on_target_enter_range(target)
signal on_target_out_of_range(target)

onready var colShap:CollisionShape = $Area/CollisionShape
onready var Area_check:Area=$Area

var target_list:Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sh = CylinderShape.new()
	sh.set_radius(radius)
	sh.set_height(Hieght)
	colShap.shape = sh
	Area_check.collision_layer = LayerUsed
	Area_check.collision_mask = MaskUsed

func get_target_list()->Array:
	var a:Array = Area_check.get_overlapping_areas()
	a.append_array(Area_check.get_overlapping_bodies())
	return a

func is_target_in_range(target):
	return target in target_list

func _on_Area_body_entered(body: Node) -> void:
	target_list.append(body)
	emit_signal("on_target_enter_range", body)	


func _on_Area_body_exited(body: Node) -> void:
	if target_list.has(body):
		target_list.erase(body)
		emit_signal("on_target_out_of_range", body)


func _on_Area_area_entered(area: Area) -> void:
	target_list.append(area)
	emit_signal("on_target_enter_range", area)	


func _on_Area_area_exited(area: Area) -> void:
	if target_list.has(area):
		target_list.erase(area)
		emit_signal("on_target_out_of_range", area)
