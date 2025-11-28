extends Node

var player1Round = 0
var player2Round = 0

func _ready():

	var passname = find_child("check")
	passname.connect("passed", _passer)
	
	var passname2 = find_child("check2")
	passname2.connect("passed", _passer)
	

func _passer(nameSake, passSake):
	print("nameSake:", nameSake)
	print("passSake:", passSake)
