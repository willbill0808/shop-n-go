extends CharacterBody2D

# --- MODE SWITCH ---
var modes := ["NORMAL", "ICE"]
var mode := "NORMAL"

# -------------------------
# NORMAL MOVEMENT VALUES
# -------------------------
@export var normal_speed := 500

# -------------------------
# ICE MOVEMENT VALUES
# -------------------------
@export var max_speed := 450.0
@export var accel := 350.0
@export var ice_friction := 0.01
@export var brake_force := 0
@export var hard_turn_stop := 0     # 0.0 = ingen stopp, 0.95 = nesten full stopp ved snu


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
			Input.get_axis("LEFT_1", "RIGHT_1"),
			Input.get_axis("UP_1", "DOWN_1")
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
		Input.get_axis("LEFT_1", "RIGHT_1"),
		Input.get_axis("UP_1", "DOWN_1")
	).normalized()

	if input_dir != Vector2.ZERO:

		# HARD TURN STOP
		if velocity.length() > 5.0 and velocity.dot(input_dir) < 0:
			velocity *= (1.0 - hard_turn_stop)

		# Accelerate
		var target := input_dir * max_speed
		velocity = velocity.move_toward(target, accel * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, brake_force * delta)

	# Ice gliding
	velocity *= (1.0 - ice_friction)

	move_and_slide()
