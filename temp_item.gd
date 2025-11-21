extends StaticBody2D

var entered = false
var spawn_nodes = []
var node_modes = {}
var taken_nodes = []
var skoyter = ["grip", "speed", "max_speed", "snowball", "speed_boost", "ice", "crazy_grip", "crazy_speed"]

func _ready() -> void:
	repos()
	initialize_modes()
	print_modes()
	
func repos():
	spawn_nodes.clear()
	
	var placeList = get_tree().get_nodes_in_group("spawn_nodes")
	for o in placeList:
		spawn_nodes.append(o.name)
		
	var random_name = spawn_nodes[randi_range(0, spawn_nodes.size() - 1)]
	var spawnpos = get_parent().find_child(random_name).position
	
	position = spawnpos
	print("Spawned at:", random_name)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action1_1") and entered:
		repos()
		action()
		print_modes()
# Give each node a random starting mode
func initialize_modes():
	node_modes.clear()
	
	for node in spawn_nodes:
		var mode = skoyter[randi_range(0, skoyter.size() - 1)]
		
		# reroll until mode is unique
		while mode in taken_nodes:
			mode = skoyter[randi_range(0, skoyter.size() - 1)]
			
		node_modes[node] = mode
		taken_nodes.append(mode)
		
# Randomize mode every time action happens
func action():
	for node in spawn_nodes:
		node_modes[node] = skoyter[randi_range(0, skoyter.size() - 1)]
		
# Print all node → random mode pairs
func print_modes():
	for node in spawn_nodes:
		print(node, " = ", node_modes[node])
