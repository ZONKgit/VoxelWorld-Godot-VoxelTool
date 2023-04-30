extends Node


var is_fullscreen = false
var is_wireframe_mode = false


func _input(event):
	if Input.is_action_just_pressed("fullscreen"):
		if is_fullscreen: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		is_fullscreen = not GameSettings.is_fullscreen
	elif Input.is_action_just_pressed("wireframe_mode"):
		is_wireframe_mode = not is_wireframe_mode
		get_viewport().debug_draw = Viewport.DEBUG_DRAW_WIREFRAME if is_wireframe_mode else Viewport.DEBUG_DRAW_DISABLED
