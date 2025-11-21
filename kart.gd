extends Node2D

func _ready():
	var world: World2D = $World.get_world_2d()
	
	var left_vp = $UI/SubViewportContainer_Left/SubViewport_Left
	var right_vp = $UI/SubViewportContainer_Right/SubViewport_Right

	left_vp.world_2d = world
	right_vp.world_2d = world

	# Move cameras into viewports
	var cam_left = $World/Player1/Camera2D_Left
	cam_left.get_parent().remove_child(cam_left)
	left_vp.add_child(cam_left)
	cam_left.current = true

	var cam_right = $World/Player2/Camera2D_Right
	cam_right.get_parent().remove_child(cam_right)
	right_vp.add_child(cam_right)
	cam_right.current = true
