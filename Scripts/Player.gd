extends CharacterBody3D

const LERP_VALUE : float = 0.15
var snap_vector : Vector3 = Vector3.DOWN
var speed : float
var current_state = game_manager.current_state

@export_group("Movement variables")
@export var walk_speed : float = 2.0
@export var run_speed : float = 5.0
@export var jump_strength : float = 15.0
@export var gravity : float = 50.0

@onready var player_mesh : Node3D = $player
@onready var spring_arm_pivot : Node3D = $SpringArmPivot

var walking_state = game_manager.PlayerState.WALKING


func _physics_process(delta):
	if game_manager.current_state == walking_state:
		var move_direction : Vector3 = Vector3.ZERO
		move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		move_direction.z = Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forwards")
		move_direction = move_direction.rotated(Vector3.UP, spring_arm_pivot.rotation.y)
		
		velocity.y -= gravity * delta
		
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed
		
		velocity.x = move_direction.x * speed
		velocity.z = move_direction.z * speed
		
		if move_direction:
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(velocity.x, velocity.z), LERP_VALUE)
		
		var just_landed := is_on_floor() and snap_vector == Vector3.ZERO
		var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
		if is_jumping:
			velocity.y = jump_strength
			snap_vector = Vector3.ZERO
		elif just_landed:
			snap_vector = Vector3.DOWN
		
		apply_floor_snap()
		move_and_slide()
