class_name GameMap extends Node2D


@export var map_id : Maps.values = Maps.values.MAP_0

var teleports = {}
@onready var map_teleports = $Teleports

# Called when the node enters the scene tree for the first time.
func _ready():
	for teleport in map_teleports.get_children():
		teleports[teleport.teleport_id] = teleport

func get_teleport_position(connected_teleport_id):
	return teleports[connected_teleport_id].position
