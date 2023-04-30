extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _input(event):
	if Input.is_action_just_pressed("inventory"):
		visible = not visible
		$"../..".is_mouse_input = not $"../..".is_mouse_input
		if not visible:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
