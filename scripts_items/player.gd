extends CharacterBody2D

const Bullet = preload("res://scenes_items/bullet.tscn")
const Ice = preload("res://scenes_items/ice_object.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var new_Speed = SPEED * 2
var action_states = { "SPEED_BOOST": 0, "ICE": 1, "SNOWBALL": 2, "NONE": 3 }

var current_state = "NONE"

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if current_state == "SPEED_BOOST":
			velocity.x = direction * new_Speed
		else: 
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Global.snowball < 16 and current_state == "SNOWBALL" and Input.is_action_just_pressed("shoot_1"):
		shoot()

	elif current_state == "ICE" and Input.is_action_just_pressed("shoot"):
		ice()
		

	if current_state == "ICE" and Input.is_action_just_pressed("shoot_1"):
		ice()
		

	if current_state == "ICE" and Input.is_action_just_pressed("shoot_1"):
		ice()
		

	if Input.is_action_just_pressed("action1_1"):
		action()
		
	move_and_slide()   
	
	
func action():
	var keys = action_states.keys()
	var current_index = keys.find(current_state)
	var next_index = (current_index + 1) % keys.size()
	
	current_state = keys[next_index]
	
	match current_state:
		"SPEED_BOOST":
			print("its_speed_time")
		"SNOWBALL":
			print("snowballs!!!")
		"ICE":
			print("slipperytime")
		"NONE":
			print("nothing happening")
			
			
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_E:
			action()

func shoot():
	var marker = $Marker2D
	var b = Bullet.instantiate()
	b.global_position = marker.global_position
	get_tree().current_scene.add_child(b)
	Global.snowball += 1

func ice():
	var marker = $Marker2D
	var b = Ice.instantiate()
	b.global_position = marker.global_position
	get_tree().current_scene.add_child(b)
