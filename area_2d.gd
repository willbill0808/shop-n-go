extends Area2D

var mode: String = ""

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1") and Global.player_item_1 == false:
		Global.player_item_1 = true

		print("DEBUG: Trying to call temp_item with mode =", mode)

		var controller = get_node_or_null("/root/kart/temp_item")
		print("DEBUG: controller =", controller)

		if controller:
			controller.on_spawn_node_collected(mode)
		else:
			print("ERROR: Could not find /root/kart/temp_item")

		queue_free()
