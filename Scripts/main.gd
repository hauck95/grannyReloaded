extends Node3D

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta: float) -> void:
	print(game_manager.current_state)
