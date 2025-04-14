extends Node3D
@onready var player: CharacterBody3D = $Player
@onready var car_camera: Camera3D = $Car/SpringArmPivot/SpringArm3D/Camera3D
@onready var player_camera: Camera3D = $Player/SpringArmPivot/SpringArm3D/Camera3D
@onready var car: VehicleBody3D = $Car

@export var player_offset_next_to_car = Vector3(0, 0, 2)

var driving_state = game_manager.PlayerState.DRIVING
var walking_state = game_manager.PlayerState.WALKING
var player_is_driving: bool

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta: float) -> void:
	#drive
	if game_manager.current_state == walking_state and Input.is_action_just_pressed("toggle_driving"):
		change_player_state(driving_state, true, false)
	#walk
	elif game_manager.current_state == driving_state and Input.is_action_just_pressed("toggle_driving"):
		change_player_state(walking_state, false, true)
		spawn_player_next_to_object(car)

	if player_is_driving:
		player.position = car.position
		player.collision_layer = 0
	else:
		player.collision_layer = 1


func change_player_state(new_state: int, car_camera_state: bool, player_camera_state: bool) -> void:
	game_manager.current_state = new_state
	car_camera.current = car_camera_state
	player_camera.current = player_camera_state
	player_is_driving = new_state

func spawn_player_next_to_object(object: Object) -> void:
	player.global_transform.origin = object.global_transform.origin + player_offset_next_to_car
	object.global_transform.origin = object.global_transform.origin + Vector3(0, 0.002, 0)
