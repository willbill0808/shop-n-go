extends Area2D

@onready var presser = $presser2
var entered = false

func _ready() -> void:
	presser.hide()
	
func _on_body_entered(_body: CharacterBody2D) -> void:
	presser.show()
	presser.play("default_E")
	print("enter")
	get_parent().entered = true

func _on_body_exited(_body: CharacterBody2D) -> void:
	presser.stop()
	presser.hide()
	print("exit")
	get_parent().entered = false
