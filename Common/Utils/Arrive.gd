class_name GSAIArrive
const arrival_tolerance=0.5
const time_to_reach := 0.1
const deceleration_radius: float=0.2

static func get_linear(target_position: Vector3,current_position:Vector3,desired_speed:float,linear_velocity:Vector3,linear_acceleration_max:float)->Vector3:
	var to_target := target_position - current_position
	var distance := to_target.length()
	if distance <= arrival_tolerance:
		return Vector3.ZERO
	if distance <= deceleration_radius:
			desired_speed *= distance / deceleration_radius
	var desired_velocity := to_target * desired_speed / distance
	desired_velocity = ((desired_velocity - linear_velocity) * 1.0 / time_to_reach)
	return GSAIUtils.clampedv3(desired_velocity, linear_acceleration_max)
