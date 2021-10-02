extends CharacterBody2D

enum state {
	LOOK,
	WALK,
	RUN
}

var velocity_map = {
	state.LOOK: 0,
	state.WALK: 4,
	state.RUN: 8
}

@export_range(8, 64, 8) var tile_size : int = 16
@export var movement_velocity : int = 8

@onready var animation_tree = $AnimationTree

var input_direction : Vector2
var look_direction : Vector2
var new_position : Vector2

var snap_vector = Vector2.ZERO

var input_duration : float = 0
var current_state : state = state.LOOK

# Called when the node enters the scene tree for the first time.
func _ready():
	snap_vector = Vector2(tile_size, tile_size)
	new_position = position.snapped(snap_vector)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move():
		process_input(delta)
	
	if moving():
		move(look_direction, delta)
	
#	camera.position = position

func process_input(delta):
	input_direction = get_input()

	if input_direction == Vector2.ZERO:
		input_duration = 0
		current_state = state.LOOK
	else:
		input_duration += delta
		look_direction = input_direction
		if input_duration > delta * 4:
			if Input.is_action_pressed("run"):
				current_state = state.RUN
			else:
				current_state = state.WALK
			new_position = position + look_direction * tile_size
	
	movement_velocity = velocity_map[current_state]
	animation_tree.set("parameters/Look/blend_position", look_direction)
	animation_tree.set("parameters/Walk/blend_position", look_direction)
	animation_tree.set("parameters/Run/blend_position", look_direction)
	animation_tree.set("parameters/State/current", current_state)

func get_input():
	if Input.get_action_strength("move_up") == 1:
		return Vector2.UP
	elif Input.get_action_strength("move_right") == 1:
		return Vector2.RIGHT
	elif Input.get_action_strength("move_down") == 1:
		return Vector2.DOWN
	elif Input.get_action_strength("move_left") == 1:
		return Vector2.LEFT
	
	return Vector2.ZERO

func move(direction, delta):
	position += direction * tile_size * delta * movement_velocity
	if new_position_reached():
		position = position.snapped(snap_vector)

func can_move():
	return new_position_reached()

func new_position_reached():
	return position.distance_to(new_position) <= 1

func moving():
	return !new_position_reached()
