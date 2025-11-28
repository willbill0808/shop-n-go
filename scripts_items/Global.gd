extends Node2D

var snowball = 0

var volume = 0
var grip_1 = []
var grip_2 = []
var max_speed_1 = []
var max_speed_2 = []
var speed_1 = []
var speed_2 = []
var item_1 = []
var item_2 = []

var player_item_1 = false
var player_item_2 = false

var player_helmet_1 = false
var palyer_helmet_2 = false

var player_skoyter_1 = false
var player_skoyter_2 = false

var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _ready():
	var my_random_number = rng.randf_range(0, 3)
	if my_random_number == 0:
		$Player1.current_state = "SPEED_BOOST"
	elif my_random_number == 1:
		$Player1.current_state = "SPEED_BOOST_2"
	elif my_random_number == 2:
		$Player1.current_state = "SPEED_BOOST_3"
	elif my_random_number == 3:
		$Player1.current_state = "SPEED_BOOST_4"
	var my_random_number2 = rng2.randf_range(0, 3)
	if my_random_number2 == 0:
		$Player2.current_state = "SPEED_BOOST"
	elif my_random_number2 == 1:
		$Player2.current_state = "SPEED_BOOST_2"
	elif my_random_number2 == 2:
		$Player2.current_state = "SPEED_BOOST_3"
	elif my_random_number2 == 3:
		$Player2.current_state = "SPEED_BOOST_4"
