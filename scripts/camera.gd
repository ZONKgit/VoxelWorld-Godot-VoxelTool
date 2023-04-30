extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var SPEED_TURN = 0.003

func _input(e):
	if $"..".is_mouse_input:
		if e is InputEventMouseMotion:
			$".".rotation.x = clamp($".".rotation.x-e.relative.y * SPEED_TURN, -1.5, 1.5)
