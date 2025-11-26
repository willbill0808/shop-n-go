extends Node

func _ready():
	# Get the world
	var world: World2D = $World.get_world_2d()

	# Get SubViewports
	var left_vp = $UI/SubViewportContainer_Left/SubViewport_Left
	var right_vp = $UI/SubViewportContainer_Right/SubViewport_Right

	# Assign the same world to both SubViewports
	left_vp.world_2d = world
	right_vp.world_2d = world

	# Move Player1 camera into left SubViewport
	var cam_left = $World/Player1/Camera2D_Left
	cam_left.get_parent().remove_child(cam_left)
	left_vp.add_child(cam_left)

	# Move Player2 camera into right SubViewport
	var cam_right = $World/Player2/Camera2D_Right
	cam_right.get_parent().remove_child(cam_right)
	right_vp.add_child(cam_right)
	
	
	var passname = get_parent().find_child("check")
	passname.connect("passed", Callable(self, "_passer",))
	

func _passer(sake):
	print(sake)
	print("passer")
