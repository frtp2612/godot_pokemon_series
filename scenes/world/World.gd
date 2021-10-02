extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("load_main_scene")

func load_main_scene():
	SceneChanger.change_scene(Maps.values.MAP_0)
