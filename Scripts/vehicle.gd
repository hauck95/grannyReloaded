extends VehicleBody3D
@onready var camera_3d: Camera3D = $SpringArmPivot/SpringArm3D/Camera3D
var driving_state = game_manager.PlayerState.DRIVING


func _physics_process(delta: float) -> void:
	if game_manager.current_state == driving_state:
		engine_force = Input.get_axis("move_backwards", "move_forwards") * 150
		steering = Input.get_axis("move_right", "move_left") * 0.4
