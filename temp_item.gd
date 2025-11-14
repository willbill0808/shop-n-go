extends StaticBody2D

var placeList = ["spawn_node1", "spawn_node2", "spawn_node3", "spawn_node4", "spawn_node5", "spawn_node6"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ranger = len(placeList) - 1
	var nodeName = placeList[randi_range(0, ranger)]
	var spawnpos = get_parent().find_child(nodeName).position
	 
	position = spawnpos
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
