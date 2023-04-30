extends Node


func _ready():
	pass

var distance_ray_cast = 10 #Длина рейкаста для установки и уничтоженяи блоков
var destroy_stage = -1 # Стадия уничтожения блока, если 0 то не уничтожаеться (Необходимо для изменения текстуры курсора)

var destroy_voxel_time = {
	"1" : 0.07,
	"2" : 0.01,
	"3" : 0.12,
	"4" : 0.045,
	"5" : 0.01,
	"6" : 0.01,
	"7" : 0.01,
	"8" : 0.01,
	"9" : 0.01,
}

var select_inventory_bar_slot = 1

func _process(delta):
	var hit = get_pointed_voxel()
	var hit_raw_id = -1
	
	if hit:
		G._cursor.show()
		G._cursor.position = hit.position
		G._cursor.position += Vector3(0.5,0.5,0.5)
		
		hit_raw_id = G.voxel_tool.get_voxel(hit.position)
	else:
		G._cursor.hide()

func _input(event):
	
	if Input.is_action_just_pressed("1slot"):
		select_inventory_bar_slot = 1
		$"../hud/inventory_bar/inventory_bar_select".position.x = 0
	elif Input.is_action_just_pressed("2slot"):
		select_inventory_bar_slot = 2
		$"../hud/inventory_bar/inventory_bar_select".position.x = 75
	elif Input.is_action_just_pressed("3slot"):
		select_inventory_bar_slot = 3
		$"../hud/inventory_bar/inventory_bar_select".position.x = 150
	elif Input.is_action_just_pressed("4slot"):
		select_inventory_bar_slot = 4
		$"../hud/inventory_bar/inventory_bar_select".position.x = 225
	elif Input.is_action_just_pressed("5slot"):
		select_inventory_bar_slot = 5
		$"../hud/inventory_bar/inventory_bar_select".position.x = 300
	elif Input.is_action_just_pressed("6slot"):
		select_inventory_bar_slot = 6
		$"../hud/inventory_bar/inventory_bar_select".position.x = 375
	elif Input.is_action_just_pressed("7slot"):
		select_inventory_bar_slot = 7
		$"../hud/inventory_bar/inventory_bar_select".position.x = 450
	elif Input.is_action_just_pressed("8slot"):
		select_inventory_bar_slot = 8
		$"../hud/inventory_bar/inventory_bar_select".position.x = 525
	elif Input.is_action_just_pressed("9slot"):
		select_inventory_bar_slot = 9
		$"../hud/inventory_bar/inventory_bar_select".position.x = 600

func get_pointed_voxel() -> VoxelRaycastResult:
	var camera = $"../camera"
	
	var origin = camera.get_global_transform().origin
	
	var forward = $"../camera/Marker3D".get_global_transform().origin
	forward -= origin
	var hit = G.voxel_tool.raycast(origin, forward, distance_ray_cast)
	return hit
	

func set_voxel(is_place, voxel_id = 0):
	var hit = get_pointed_voxel()
	if hit:
		if is_place: # Установка вокселя
			var pos = hit.previous_position
			print(Vector3i($"..".position.x, $"..".position.y, $"..".position.z) - Vector3i(hit.position.x, hit.position.y, hit.position.z))
			if Vector3i($"..".position) != Vector3i(hit.previous_position.x,hit.previous_position.y, hit.previous_position.z):
				G.voxel_tool.set_voxel(pos, select_inventory_bar_slot) #Установка блока
				Sounds.play_block_place_sound(select_inventory_bar_slot, hit.previous_position) #Воспроизведение звука
				
		else: # Уничтожение вокселя
			if $Timer.is_stopped():
				$Timer.start()
			var pos = hit.position
		

var old_voxel_pos = Vector3i(0,421,0)

func _on_timer_timeout(): #Destroy stage up
	var hit = get_pointed_voxel()
	if hit:
		var voxel_id = G.voxel_tool.get_voxel(hit.position)

		if Input.is_action_pressed("attack"):
			if not $"../camera/hand/AnimationPlayer".is_playing():
				$"../camera/hand/AnimationPlayer".play("destroing_block")
			if old_voxel_pos == hit.position or old_voxel_pos == Vector3i(0,421,0): #Проверка ломанного вокселя (Для того чтобы ломание не продолжадось на другом блоке)
				$Timer.wait_time = float(destroy_voxel_time[str(voxel_id)])
				
				destroy_stage += 1
				
				G._cursor.mesh.material.albedo_texture = load("res://assets/textures/blocks/destroy_stage_"+str(destroy_stage)+".png")
				if destroy_stage == 10:
					Sounds.play_block_place_sound(G.voxel_tool.get_voxel(hit.position), hit.position)
					G.voxel_tool.set_voxel(hit.position, 0) #Ломание вокселя
					destroy_stage = -1
					G._cursor.mesh.material.albedo_texture = load("res://assets/textures/cursor.png")
				old_voxel_pos = hit.position
			else:
				old_voxel_pos = Vector3i(0,421,0)
				destroy_stage = -1
		else:
			$"../camera/hand/AnimationPlayer".stop()
			destroy_stage = -1
			G._cursor.mesh.material.albedo_texture = load("res://assets/textures/cursor.png")
