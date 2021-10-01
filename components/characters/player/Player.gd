extends CharacterBody2D

@export_range(8, 64, 8) var tile_size : int = 16
@export var movement_velocity : int = 8

@onready var animation_tree = $AnimationTree

var input_direction : Vector2
var look_direction : Vector2
var new_position : Vector2

var snap_vector = Vector2.ZERO

enum state {
	LOOK,
	WALK,
	RUN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	snap_vector = Vector2(tile_size, tile_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move():
		process_input(delta)
	
	if moving():
		move(input_direction, delta)

func process_input(delta):
	input_direction = get_input()
	if input_direction == Vector2.ZERO:
		animation_tree.set("parameters/State/current", state.LOOK)
	else:
		look_direction = input_direction
		animation_tree.set("parameters/State/current", state.WALK)
	animation_tree.set("parameters/Look/blend_position", look_direction)
	animation_tree.set("parameters/Walk/blend_position", look_direction)
	new_position = position + input_direction * tile_size

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
