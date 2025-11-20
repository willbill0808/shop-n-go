extends CharacterBody2D

@export var max_speed := 450.0
@export var accel := 350.0
@export var ice_friction := 0.01
@export var brake_force := 40.0

# Hvor hardt du stopper ved retningsskifte
@export var hard_turn_stop := 0.95   # 0.0 = ingen stopp, 0.95 = nesten full stopp

func _physics_process(delta):
	var input_dir := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
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

		var target = input_dir * max_speed
		velocity = velocity.move_toward(target, accel * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, brake_force * delta)

	velocity *= (1.0 - ice_friction)

	move_and_slide()
