extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1") and Input.is_action_just_pressed("action1_1"):
		Global.player_item_1 = true
		queue_free()
		print("item_slot_taken")  
	elif area.is_in_group("player2") and Input.is_action_just_pressed("action1_1"):
		Global.player_item_2 = true
		queue_free()
		print("item_slot_taken")  
