extends StaticBody2D

var entered = false
var spawn_nodes = []
var node_modes = {}
var taken_nodes = []

var skoyter = ["grip", "speed", "max_speed", "snowball", "speed_boost", "ice", "crazy_grip", "crazy_speed"]

@onready var sprite = $Sprite2D

var mode_sprites = {
	"grip": preload("res://icon (copy).svg"),
	"speed": preload("res://icon.svg"),
	"max_speed": preload("res://icon (copy).svg"),
	"snowball": preload("res://snOball 1.png"),
	"speed_boost": preload("res://New Piskel 1.png"),
	"ice": preload("res://icon (copy).svg"),
	"crazy_grip": preload("res://icon.svg"),
	"crazy_speed": preload("res://icon.svg")
}

func _ready() -> void:
	repos()
	initialize_modes()
	update_all_spawn_node_sprites()
	print_modes()

func repos():
	spawn_nodes.clear()
	
	var placeList = get_tree().get_nodes_in_group("spawn_nodes")
	for o in placeList:
		spawn_nodes.append(o.name)
		
	var random_name = spawn_nodes[randi_range(0, spawn_nodes.size() - 1)]
	var spawnpos = get_parent().find_child(random_name).position
	position = spawnpos

func _process(delta: float) -> void:
	if player1_in_area == true:
		print("DREP WILLIAM")

# Give each node a random *unique* starting mode
func initialize_modes():
	node_modes.clear()
	taken_nodes.clear()
	
	for node in spawn_nodes:
		var mode = skoyter[randi_range(0, skoyter.size() - 1)]
		
		while mode in taken_nodes:
			mode = skoyter[randi_range(0, skoyter.size() - 1)]
		
		node_modes[node] = mode
		taken_nodes.append(mode)

func action():
	# Randomize all nodes’ modes
	for node in spawn_nodes:
		node_modes[node] = skoyter[randi_range(0, skoyter.size() - 1)]
	
	# Update all sprites
	update_all_spawn_node_sprites()
func update_all_spawn_node_sprites():
	for node_name in spawn_nodes:
		var node = get_parent().find_child(node_name)
		if node == null:
			continue
		
		var mode = node_modes[node_name]
		
		if node.has_node("Sprite2D"):
			node.scale = Vector2(0.1, 0.1)
			var spr = node.get_node("Sprite2D")
			if mode_sprites.has(mode):
				spr.texture = mode_sprites[mode]
			else:
				print("Missing sprite for mode:", mode)
		else:
			print(node_name, " has no Sprite2D child")

# Debug printing
func print_modes():
	for node in spawn_nodes:
		print(node, " = ", node_modes[node])
		
var player1_in_area = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	player1_in_area = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player1"):
		player1_in_area = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	player1_in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player1"):
		player1_in_area = false

func _enter_tree():
	Vector2(-30,90)
