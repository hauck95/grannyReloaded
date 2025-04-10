extends Node3D

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
