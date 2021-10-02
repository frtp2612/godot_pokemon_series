extends Node


const maps = {
	Maps.values.MAP_0: preload("res://scenes/world/maps/TestMap/TestMap.tscn"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_map(map_id):
	return maps[map_id]
