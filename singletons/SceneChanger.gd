extends Node

var scenes_cache = {}

var current_scene = null
var root
var maps

func _ready():
	root = get_tree().get_root()
	if root.get_child_count() > 0:
		maps = root.get_node("Game/World/Maps")

func change_scene(map_id):
	call_deferred("_deferred_goto_scene", map_id)

func _deferred_goto_scene(map_id):
	
	for map in maps.get_children():
		if scenes_cache.has(map.map_id):
			scenes_cache[map.map_id] = map
		maps.remove_child(map)
			
	if scenes_cache.has(map_id):
		current_scene = scenes_cache[map_id]
	else:
		current_scene = GameResources.get_map(map_id).instantiate()
	
	# Add it to the active scene, as child of root.
	maps.add_child(current_scene)
