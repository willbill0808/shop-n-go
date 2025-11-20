extends Area2D

var speed = 750
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= transform.x * speed * delta  



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("shootable"):
		#karakter sin movement men mer freaky
		area.queue_free()
		queue_free()
		print("shootable")  
