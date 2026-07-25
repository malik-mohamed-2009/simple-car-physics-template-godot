extends VehicleBody3D

@export var force_value = 1200
var get_forced: float

var speed_kmh: float
var steer_input: float

@export var gear_situation = [0, 0, 15, 30, 45, 60]

@export var engine_audio_idle = 1.0
var engine_audio_idle_2: float

@export var energetic_speed = 2.0
var energetic_speed_2: float

var gear: int

@export var engine_start: bool

func _physics_process(delta):
	engine_force = Input.get_axis("brake", "throttle") * get_forced
	
	steer_input = Input.get_axis("steer_right", "steer_left")
	steering = move_toward(steering, steer_input * deg_to_rad(25), 0.04)
	
	speed_kmh = linear_velocity.length() * 3.6
	$EngineSfx.pitch_scale = move_toward($EngineSfx.pitch_scale, (speed_kmh / gear_situation[gear + 1]) * energetic_speed_2 + engine_audio_idle_2, 0.1)
	
	$Cam.global_position = position + Vector3(0, 1, 0)
	$Cam.global_rotation.y = lerp_angle($Cam.global_rotation.y, rotation.y, speed_kmh * 0.001)
	
	if speed_kmh > gear_situation[gear] and gear < gear_situation.size() - 2: gear += 1
	if speed_kmh < gear_situation[gear] - 1: gear -= 1
	
	if speed_kmh < gear_situation.max() and engine_start:
		get_forced = force_value
	else:
		get_forced = 0
	
	if engine_start:
		engine_audio_idle_2 = engine_audio_idle
		energetic_speed_2 = energetic_speed
	else:
		engine_audio_idle_2 = 0.0
		energetic_speed_2 = 0.0
