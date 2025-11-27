extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _check_and_free(node: Node) -> void:
	if node.is_in_group("player1") or node.is_in_group("player2"):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	_check_and_free(area)

func _on_body_entered(body: Node2D) -> void:
	_check_and_free(body)

func _on_area_2d_body_entered(body: Node2D) -> void:
	_check_and_free(body)

func _on_area_2d_area_entered(area: Area2D) -> void:
	_check_and_free(area)
