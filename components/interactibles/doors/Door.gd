extends Interactible

@export var door_number : int = 1
@export var connected_area : Maps.values = Maps.values.MAP_0
@export var connected_teleport_id : int = 0
@export var teleport_id : int = 0

@export var telport_direction : Directions.values = Directions.values.DOWN

@onready var animation_player = $AnimationPlayer

var player_temp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func execute_action(player):
	animation_player.play("OpenDoor" + str(door_number))
	print("now the player should move and teleport!")
	player_temp = player


func _on_AnimationPlayer_animation_finished(anim_name):
	player_temp.update_new_position()
	player_temp.disable_collider()
	SceneChanger.change_scene(connected_area, connected_teleport_id, player_temp)
