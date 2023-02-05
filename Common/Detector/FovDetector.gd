extends Spatial

class_name FovDetector

export(float) var field_of_view = 60

func is_target_inside_fov(target:Spatial):
	var pos = global_transform.origin
	var direction = global_transform.basis.z
	var target_pos = target.transform.origin
	
	return is_inside_cone(pos, direction, target_pos)
	
func is_inside_cone(cone_tip, cone_normal:Vector3, point):
	var differenceVector:Vector3 = point - cone_tip
	differenceVector = differenceVector.normalized()

	# Dot product of 2 vectors => the cosine of the angle between them
	# Note: only when the vectors are normalized
	return cone_normal.dot(differenceVector) >= cos(deg2rad(field_of_view/2))
