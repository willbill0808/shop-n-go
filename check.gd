extends Area2D

var selfpassed = false

signal passed(nameSake, passSake)
var body_name

func _ready() -> void:
	print("DONE")

func _on_body_entered(body: Node2D) -> void:
	print (body.name)
	var bodName = body.name
	emit_signal("passed", bodName, name)
