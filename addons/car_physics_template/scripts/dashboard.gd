extends CanvasLayer

func _on_car_speed_changed(kmh_speed: float):
	$SpmLabel.text = str(int(kmh_speed)) + " km/h"
