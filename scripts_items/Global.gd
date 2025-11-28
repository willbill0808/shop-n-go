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
var player_helmet_2 = false

var player_skoyter_1 = false
var player_skoyter_2 = false

var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _ready():
	pass
