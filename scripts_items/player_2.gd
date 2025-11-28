extends CharacterBody2D


const SPEED = 1000
const JUMP_VELOCITY = -400.0

@export var max_speed := 1000
@export var accel := 350.0
@export var ice_friction := 0.01
@export var brake_force := 40.0

var current_state = "NONE"
@export var boost_multiplier := 2.5
var speed_multiplier = 1.0
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

		var target = input_dir * max_speed
		velocity = velocity.move_toward(target, accel * delta)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, brake_force * delta)

	velocity *= (1.0 - ice_friction)
	
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

	move_and_slide()
