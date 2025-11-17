extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("shootable"):
		#speedplayer2 / 2
		#createtimer
		#speedplayer2 * 2
		area.queue_free()
		queue_free()
		print("shootable")  
