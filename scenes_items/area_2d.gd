extends Area2D

var mode: String = ""

# Assign mode safely
func set_mode(new_mode: String) -> void:
	mode = new_mode

# Handle player pickup
func _on_area_entered(area: Area2D) -> void:
	var controller = get_node_or_null("/root/kart/temp_item")
	if controller == null:
		return
		
	# PLAYER 1
	if area.is_in_group("player1"):
		if not Global.player_item_1 and mode in controller.skoyter:
			Global.player_item_1 = true
			controller.on_spawn_node_collected(mode)
			Global.item_1.append(controller.on_spawn_node_collected(mode))
			queue_free()
		elif not Global.player_helmet_1 and mode in controller.helmet_items:
			Global.player_helmet_1 = true
			controller.on_spawn_node_collected(mode)
			Global.grip_1.append(controller.on_spawn_node_collected(mode))
			Global.max_speed_1.append(controller.on_spawn_node_collected(mode))
			queue_free()
		elif not Global.player_skoyter_1 and mode in controller.skoyter_nodes:
			Global.player_skoyter_1 = true
			controller.on_spawn_node_collected(mode)
			Global.speed_1.append(controller.on_spawn_node_collected(mode))
			queue_free()

	# PLAYER 2
	elif area.is_in_group("player2"):
		if not Global.player_item_2 and mode in controller.skoyter:
			Global.player_item_2 = true
			controller.on_spawn_node_collected(mode)
			Global.item_2.append(controller.on_spawn_node_collected(mode))
			queue_free()
		elif not Global.player_helmet_2 and mode in controller.helmet_items:
			Global.player_helmet_2 = true
			controller.on_spawn_node_collected(mode)
			Global.grip_2.append(controller.on_spawn_node_collected(mode))
			Global.max_speed_2.append(controller.on_spawn_node_collected(mode))
			queue_free()
		elif not Global.player_skoyter_2 and mode in controller.skoyter_nodes:
			Global.player_skoyter_2 = true
			controller.on_spawn_node_collected(mode)
			Global.speed_2.append(controller.on_spawn_node_collected(mode))
			queue_free()
