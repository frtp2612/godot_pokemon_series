extends Node


const maps = {
	Maps.values.MAP_0: "res://scenes/world/maps/TestMap/TestMap.tscn",
	Maps.values.MAP_0_1: "res://scenes/world/maps/TestHouse/TestMap01.tscn"
}

var loaded_maps = {
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_map(map_id):
	return loaded_maps[map_id]
