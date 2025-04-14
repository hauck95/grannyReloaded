extends Node3D
@onready var player: CharacterBody3D = $Player
@onready var car_camera: Camera3D = $Car/SpringArmPivot/SpringArm3D/Camera3D
@onready var player_camera: Camera3D = $Player/SpringArmPivot/SpringArm3D/Camera3D

var driving_state = game_manager.PlayerState.DRIVING
var walking_state = game_manager.PlayerState.WALKING


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta: float) -> void:
	#walking to driving
	if Input.is_action_just_pressed("toggle_driving") and game_manager.current_state == walking_state:
		game_manager.current_state = driving_state
		car_camera.current = true
		player_camera.current = false
	#driving to walking
	elif Input.is_action_just_pressed("toggle_driving") and game_manager.current_state == driving_state:
		game_manager.current_state = walking_state
		car_camera.current = false
		player_camera.current = true
