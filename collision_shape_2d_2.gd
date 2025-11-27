extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player1") or area.is_in_group("player2"):
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player1") or body.is_in_group("player2"):
		queue_free()
