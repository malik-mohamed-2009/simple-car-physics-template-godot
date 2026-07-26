extends SpringArm3D

func _on_car_cam_connect(main_position: Vector3, main_rotation: Vector3) -> void:
	position = main_position + Vector3(0, 1, 0)
	rotation.y = lerp_angle(rotation.y, main_rotation.y, 0.03)
