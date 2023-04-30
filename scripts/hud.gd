extends Control


var player_position = null
var target_block_position = null

var chat_text = null


func _process(delta):
	player_position = Vector3i($"..".position)
	if $"../interaction".get_pointed_voxel(): target_block_position = str($"../interaction".get_pointed_voxel().position)
	
	$debug_info.text = str("position: ", player_position)
	$debug_info.text += str("\ntarget_block_position: ", target_block_position)
	


