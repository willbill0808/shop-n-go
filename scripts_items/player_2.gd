extends CharacterBody2D

const Bullet = preload("res://scenes_items/bullet.tscn")
const Ice = preload("res://scenes_items/ice_object.tscn")

var new_Speed = SPEED * 2
var action_states = { "SPEED_BOOST": 0, "ICE": 1, "SNOWBALL": 2, "NONE": 3 }

var current_state = "NONE"

@export var boost_multiplier := 2.5


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var max_speed := 450.0
@export var accel := 350.0
@export var ice_friction := 0.01
@export var brake_force := 40.0

# Hvor hardt du stopper ved retningsskifte
@export var hard_turn_stop := 0   # 0.0 = ingen stopp, 0.95 = nesten full stopp

func _physics_process(delta):
	var input_dir := Vector2(
		Input.get_action_strength("RIGHT_1") - Input.get_action_strength("LEFT_1"),
		Input.get_action_strength("DOWN_1") - Input.get_action_strength("UP_1")
	).normalized()

	if input_dir != Vector2.ZERO:

		# ---------------------------------------------------
		# HARD-STOP VED RETNINGSSKIFTE
		# Dette gir nesten INGEN glidning når du snur.
		# ---------------------------------------------------
		if velocity.length() > 5.0 and velocity.dot(input_dir) < 0:
			velocity *= (1.0 - hard_turn_stop)
			# Dette kutter nesten hele farten brått:
			# hard_turn_stop = 0.95 → beholder kun 5% av farten
		# ---------------------------------------------------

		if current_state == "SPEED_BOOST":
			var boosted_speed = max_speed * boost_multiplier
			var target = input_dir * boosted_speed
			velocity = velocity.move_toward(target, accel * delta * boost_multiplier)
		else:
			var target = input_dir * max_speed
			velocity = velocity.move_toward(target, accel * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, brake_force * delta)

	velocity *= (1.0 - ice_friction)
	
	if Global.snowball_1 < 16 and current_state == "SNOWBALL" and Input.is_action_just_pressed("shoot"):
		shoot()
	elif current_state == "ICE" and Input.is_action_just_pressed("shoot"):
		ice()
		
	if current_state == "ICE" and Input.is_action_just_pressed("shoot_1"):
		ice()
		
	if current_state == "ICE" and Input.is_action_just_pressed("shoot_1"):
		ice()
		

		

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
	Global.snowball_1 += 1

func ice():
	var marker = $Marker2D
	var b = Ice.instantiate()
	b.global_position = marker.global_position
	get_tree().current_scene.add_child(b)
