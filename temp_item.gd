extends StaticBody2D

var entered = false

func _ready() -> void:

	repos() #kjører randomizer repositioning på starten av projectet

func repos():
	var placeList = get_tree().get_nodes_in_group("spawn_nodes")
	var placeName = []
	for o in placeList:
		placeName.append(o.name)
	var nodeName = placeName[randi_range(0, len(placeList) - 1 )] #får et tilfeldig tall som skal bli brukt når den velger position
	var spawnpos = get_parent().find_child(nodeName).position #finner noden valgt
	
	position = spawnpos #setter den nye positionen


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action1_1"): #når man kaller "action1" (det gjør man via å trykke "e" i dette projektet) så kjører koden i if indenten
		if entered:
			repos()
