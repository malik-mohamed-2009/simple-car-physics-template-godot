extends VehicleBody3D

@export var force_value = 1200.0

var speed_kmh: float
var steer_input: float

func _physics_process(delta):
	engine_force = Input.get_axis("ui_down", "ui_up") * force_value
	
	steer_input = Input.get_axis("ui_right", "ui_left")
	steering = move_toward(steering, steer_input * deg_to_rad(25), 0.04)
	
	speed_kmh = linear_velocity.length() * 3.6
	$EngineSfx.pitch_scale = (speed_kmh / 100.0) * 0.5 + 0.5
	
	$Cam.global_position = position + Vector3(0, 1, 0)
	$Cam.global_rotation.y = lerp_angle($Cam.global_rotation.y, rotation.y, speed_kmh * 0.001)
	
	# Delete the dumbest code
	if position.y < -100: queue_free()
