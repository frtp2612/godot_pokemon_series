extends Node2D

@export var connected_area : Maps.values = Maps.values.MAP_0
@export var connected_teleport_id : int = 0
@export var teleport_id : int = 0

@export var telport_direction : Directions.values = Directions.values.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func execute_action(player):
	SceneChanger.change_scene(connected_area, connected_teleport_id, player)
	
	print("now the player should move and teleport!")
