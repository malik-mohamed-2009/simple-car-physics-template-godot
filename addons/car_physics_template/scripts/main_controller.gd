extends VehicleBody3D

@export var force_value: int = 1200
var get_forced: float

var speed_kmh: float
var steer_input: float

@export var gear_situation = [0, 0, 15, 30, 45, 60]

@export var engine_audio_idle: float = 1.0
var engine_audio_idle_2: float

@export var energetic_speed: float = 2.0
var energetic_speed_2: float

var gear: int

@export var engine_start: bool

signal cam_connect

func _physics_process(delta: float) -> void:
	engine_force = Input.get_axis("ui_up", "ui_down") * get_forced
	
	steer_input = Input.get_axis("ui_right", "ui_left")
	steering = move_toward(steering, steer_input * deg_to_rad(25), 0.04)
	
	speed_kmh = linear_velocity.length() * 3.6
	$EngineSfx.pitch_scale = move_toward($EngineSfx.pitch_scale, (speed_kmh / gear_situation[gear + 1]) * energetic_speed_2 + engine_audio_idle_2, 0.1)
	
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
		engine_audio_idle_2 = 0.01
		energetic_speed_2 = 0.0
	
	camera_connection()

func camera_connection() -> void:
	var main_position: Vector3 = position
	var main_rotation: Vector3 = rotation
	cam_connect.emit(main_position, main_rotation)
