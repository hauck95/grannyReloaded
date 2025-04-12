extends VehicleBody3D

func _physics_process(delta: float) -> void:
	engine_force = Input.get_axis("move_backwards", "move_forwards") * 150
	steering = Input.get_axis("move_right", "move_left") * 0.4
