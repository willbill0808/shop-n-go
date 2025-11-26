extends Area2D

signal passed(nameSake)
var body_name

func _on_body_entered(body: Node2D) -> void:
	print (body.name)
	emit_signal("passed", body.name)
