extends Node



var player1Round = 0
var player2Round = 0

var player1check1 = false
var player1check2 = true
var player2check1 = false
var player2check2 = true

func _ready():

	var passname = find_child("check")
	passname.connect("passed", _passer)
	
	var passname2 = find_child("check2")
	passname2.connect("passed", _passer)
	
	var cam1 = $cam1
	var cam2 = $cam2
	
	cam1.make_current()
	

func bytt():
	var cam2 = $cam2
	cam2.make_current()
	
	$Player1.position = Vector2(6947, 648)
	$Player2.position = Vector2(6947, 648)
	
	$Player1.scale = Vector2(3,3)
	$Player2.scale = Vector2(0.3,0.3)

func _process(delta: float) -> void:
	
	if player1Round == 2:
		var player = "player1"
		playwin(player)
		$win1.show()
	
	if player2Round == 2:
		var player = "player2"
		playwin(player)
		$win2.show()


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_R):
		bytt()

func _passer(nameSake, passSake):
	print("nameSake:", nameSake)
	print("passSake:", passSake)
	
	if nameSake == "Player1":
		print("1")
		if passSake == "check":
			print("1")
			if player1check2 == true:
				player1check1 = true
				player1check2 = false
				
				player1Round = player1Round + 1
				print("1")
				print()
				print("play1: ", player1Round)
		else:
			print("2")
			if player1check1 == true:
				player1check2 = true
				player1check1 = false
				
				print("2")
				print()
				print("play1: ", player1check1, player1check2)

	else:
		if passSake == "check2":
			if player2check2 == true:
				player2check1 = true
				player2check2 = false
		else:
			if player2check1 == true:
				player2check2 = true
				player2check1 = false
				
				player2Round = player2Round + 1

func playwin(player):
	print(player, " vant")
	
