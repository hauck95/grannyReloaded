extends VehicleBody3D
@onready var camera_3d: Camera3D = $SpringArmPivot/SpringArm3D/Camera3D
@onready var player: CharacterBody3D = $"../Player"
var driving_state = game_manager.PlayerState.DRIVING

@export_group("Movement variables")
@export var normal_speed : int = 150
@export var steering_value : float = 0.4
@export var jump_strength : float = 15.0
@export var gravity : float = 50.0


func _physics_process(delta: float) -> void:
	if game_manager.current_state == driving_state:
		player.visible = false
		engine_force = Input.get_axis("move_backwards", "move_forwards") * normal_speed
		steering = Input.get_axis("move_right", "move_left") * steering_value
