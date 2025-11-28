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
	

func _passer(nameSake, passSake):
	print("nameSake:", nameSake)
	print("passSake:", passSake)
	
	if nameSake == "Player1":
		if passSake == "check":
			if player1check2 == true:
				player1check1 = true
				player1check2 = false
				
				print("play1: ", player1check1, player1check2)
		else:
			if player1check1 == true:
				player1check2 = true
				player1check1 = false
				
				print("play1: ", player1check1, player1check2)

	else:
		if passSake == "check":
			if player2check2 == true:
				player2check1 = true
				player2check2 = false
		else:
			if player2check1 == true:
				player2check2 = true
				player2check1 = false
