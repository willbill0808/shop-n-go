extends CharacterBody2D

const Bullet = preload("res://scenes_items/bullet.tscn")
const Ice = preload("res://scenes_items/ice_object.tscn")

var new_Speed = max_speed * 10
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
@export var hard_turn_stop := 0.0   # 0.0 = ingen stopp, 0.95 = nesten full stopp
# --- MODE SWITCH ---
var modes := ["NORMAL", "ICE"]
var mode := "NORMAL"

# -------------------------
# NORMAL MOVEMENT VALUES
# -------------------------
@export var normal_speed := 500

# -------------------------
# ICE MOVEMENT VALUES
# ----------------------adw---



func _physics_process(delta):

	# --- SWITCH MODE WITH R ---
	if Input.is_action_just_pressed("switch_mode"):  # <-- du må lage action "switch_mode" i InputMap og bind til R
		var i := modes.find(mode)
		mode = modes[(i + 1) % modes.size()]
		print("Mode:", mode)


	# ===============================================================
	# NORMAL MODE (Top-down)
	# ===============================================================
	if mode == "NORMAL":

		var dir := Vector2(
			Input.get_axis("LEFT_2", "RIGHT_2"),
			Input.get_axis("UP_2", "DOWN_2")
		).normalized()

		# Flip sprite
		if dir.x > 0: %sprite.flip_h = false
		elif dir.x < 0: %sprite.flip_h = true

		# Movement
		if dir != Vector2.ZERO:
			velocity = dir * normal_speed
			if %sprite.animation != "Walking":
				%sprite.animation = "Walking"
		else:
			velocity = velocity.move_toward(Vector2.ZERO, normal_speed)
			if %sprite.animation != "Idle":
				%sprite.animation = "Idle"

		move_and_slide()
		return



	# ===============================================================
	# ICE MODE
	# ===============================================================

	var input_dir := Vector2(
		Input.get_axis("LEFT_2", "RIGHT_2"),
		Input.get_axis("UP_2", "DOWN_2")
	).normalized()

	if input_dir != Vector2.ZERO:

		# HARD TURN STOP
		if velocity.length() > 5.0 and velocity.dot(input_dir) < 0:
			velocity *= (1.0 - hard_turn_stop)
			# Dette kutter nesten hele farten brått:
			# hard_turn_stop = 0.95 → beholder kun 5% av farten
		# Start with base speed
		var speed_multiplier = 1.0

# Apply SPEED_BOOST
		if current_state == "SPEED_BOOST":
			speed_multiplier *= boost_multiplier
			ice_friction *= 0.5
		if current_state == "SPEED_BOOST_2":
			speed_multiplier *= 1.5
			ice_friction *= 1
		if current_state == "SPEED_BOOST_3":
			speed_multiplier *= 2
			ice_friction *= 1.5
		if current_state == "SPEED_BOOST_4":
			speed_multiplier *= 3
			ice_friction *= 2

# Apply other dynamic modifiers (like snowball slow, grip, etc.)
		if is_in_group("player1"):
			for item in Global.max_speed_1:
				if item in Global.max_speed_1:  # e.g., ["speed1", "speed2"]
					speed_multiplier *= 1.2  # adjust as needed 
					break
		elif is_in_group("player2"):
			for item in Global.max_speed_2:
				if item in Global.max_speed_2:
					speed_multiplier *= 1.2
					break

# Calculate target velocity
		var target_velocity = input_dir * max_speed * speed_multiplier

# Smoothly accelerate toward target
		velocity = velocity.move_toward(target_velocity, accel * delta * speed_multiplier)


		# Accelerate
		var target := input_dir * max_speed
		velocity = velocity.move_toward(target, accel * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, brake_force * delta)


	var applied_ice_friction = ice_friction

# PLAYER 1
	if is_in_group("player1"):
		for item in Global.grip_1:
			if item in Global.grip_1:
				applied_ice_friction = 0.2  # increase friction
				break
				
# PLAYER 2
	elif is_in_group("player2"):
		for item in Global.grip_2:
			if item in Global.grip_2:
				applied_ice_friction = 0.2
				break

# Apply friction
	velocity *= (1.0 - applied_ice_friction)

	

	move_and_slide()

func shoot():
	var marker = $Marker2D
	var b = Bullet.instantiate()
	b.global_position = marker.global_position
	get_tree().current_scene.add_child(b)
	Global.snowball_2 += 1

func ice():
	var marker = $Marker2D
	var b = Ice.instantiate()
	b.global_position = marker.global_position
	get_tree().current_scene.add_child(b)
	
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
		if event.pressed and event.keycode == KEY_F:
			action()
