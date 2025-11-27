extends StaticBody2D

# --- Spawn nodes ---
var spawn_nodes = []
var node_modes = {}
var taken_nodes = []

# --- Item lists ---
var skoyter = ["snowball", "speed_boost", "ice"]
var helmet_items = ["speed1", "speed2"]
var skoyter_nodes = ["max_speed1", "extragrip", "max_speed2"]

# --- Sprite handling ---
@onready var sprite = $Sprite2D
var mode_sprites = {
	"snowball": preload("res://snOball 1.png"),
	"speed_boost": preload("res://New Piskel 1.png"),
	"ice": preload("res://icon (copy).svg"),
	"speed1": preload("res://icon (copy).svg"),
	"speed2": preload("res://icon.svg"),
	"max_speed1": preload("res://icon.svg"),
	"extragrip": preload("res://icon (copy).svg"),
	"max_speed2": preload("res://icon.svg")
}

func _ready() -> void:
	repos()
	initialize_modes()
	update_all_spawn_node_sprites()
	print_modes()

# --- Position temp_item randomly on one of the spawn nodes ---
func repos():
	spawn_nodes.clear()
	var placeList = get_tree().get_nodes_in_group("spawn_nodes")
	for o in placeList:
		spawn_nodes.append(o.name)
	
	if spawn_nodes.size() > 0:
		var random_name = spawn_nodes[randi_range(0, spawn_nodes.size() - 1)]
		var spawnpos = get_parent().find_child(random_name).position
		position = spawnpos

# --- Assign random unique modes to each spawn node ---
func initialize_modes():
	node_modes.clear()
	taken_nodes.clear()
	
	var all_items = skoyter + helmet_items + skoyter_nodes
	
	for node_name in spawn_nodes:
		var mode = all_items[randi_range(0, all_items.size() - 1)]
		while mode in taken_nodes:
			mode = all_items[randi_range(0, all_items.size() - 1)]
		node_modes[node_name] = mode
		taken_nodes.append(mode)

# --- Randomize all nodes’ modes on demand ---
func action():
	var all_items = skoyter + helmet_items + skoyter_nodes
	for node_name in spawn_nodes:
		node_modes[node_name] = all_items[randi_range(0, all_items.size() - 1)]
	update_all_spawn_node_sprites()

# --- Update sprites and assign mode to each node ---
func update_all_spawn_node_sprites():
	for node_name in spawn_nodes:
		var node = get_parent().find_child(node_name)
		if node == null:
			continue
		
		var mode = node_modes[node_name]
		
		# Update Sprite2D texture
		if node.has_node("Sprite2D"):
			node.scale = Vector2(0.1, 0.1)
			var spr = node.get_node("Sprite2D")
			if mode_sprites.has(mode):
				spr.texture = mode_sprites[mode]
		
		# Assign mode via method
		if node.has_method("set_mode"):
			node.set_mode(mode)

# --- Debug print ---
func print_modes():
	for node_name in spawn_nodes:
		print(node_name, " = ", node_modes[node_name])

# --- Called when a player picks up a node ---
func on_spawn_node_collected(mode: String):
	# This function could trigger effects based on mode
	# e.g., giving a helmet, skoyter, or temporary item
	# For now, just print
	print("Player picked up:", mode)
