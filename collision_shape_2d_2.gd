extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = $"../../../spawn_node1/Area2D/CollisionShape2D".position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
