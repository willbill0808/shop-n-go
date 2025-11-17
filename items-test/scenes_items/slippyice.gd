extends Node2D

var speed = 750



func _physics_process(delta):
	position -= transform.x * speed * delta



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("shootable"):
		#randomdirections(small)
		#set_timer
		area.queue_free()
		queue_free()
		print("shootable")  
