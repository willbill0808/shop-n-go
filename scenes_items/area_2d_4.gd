extends Area2D

var mode: String = ""

# Assign mode safely
func set_mode(new_mode: String) -> void:
	mode = new_mode

# Handle player pickup
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1") and not Global.player_item_1:
		Global.player_item_1 = true

		var controller = get_node_or_null("/root/kart/temp_item")
		if controller:
			controller.on_spawn_node_collected(mode)

		queue_free()
