extends AudioStreamPlayer3D



func _on_destroy_timer_timeout():
	queue_free()
