extends Node2D

var player1_in_area := false
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	player1_in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player1"):
		player1_in_area = false


func _process(delta):
	if player1_in_area:
		Global.player_item_1 = true
		queue_free()
		print("item_slot_taken")
