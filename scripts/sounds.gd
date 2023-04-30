extends Node


var sounds = {
	#Блок травы
	"1" : [load("res://assets/sounds/blocks/grass1.mp3"), load("res://assets/sounds/blocks/grass2.mp3"), load("res://assets/sounds/blocks/grass3.mp3"), load("res://assets/sounds/blocks/grass4.mp3")],
	#Трава
	"2" : [load("res://assets/sounds/blocks/grass1.mp3"), load("res://assets/sounds/blocks/grass2.mp3"), load("res://assets/sounds/blocks/grass3.mp3"), load("res://assets/sounds/blocks/grass4.mp3")],
	#Дерево
	"3" : [load("res://assets/sounds/blocks/wood1.mp3"), load("res://assets/sounds/blocks/wood2.mp3"), load("res://assets/sounds/blocks/wood3.mp3"), load("res://assets/sounds/blocks/wood4.mp3")],
	#Листва
	"4" : [load("res://assets/sounds/blocks/grass1.mp3"), load("res://assets/sounds/blocks/grass2.mp3"), load("res://assets/sounds/blocks/grass3.mp3"), load("res://assets/sounds/blocks/grass4.mp3")],
	#Камень
	"5" : [load("res://assets/sounds/blocks/stone1.mp3"), load("res://assets/sounds/blocks/stone2.mp3"), load("res://assets/sounds/blocks/stone3.mp3"), load("res://assets/sounds/blocks/stone4.mp3")],
	#Песок
	"6" : [load("res://assets/sounds/blocks/sand1.mp3"), load("res://assets/sounds/blocks/sand2.mp3"), load("res://assets/sounds/blocks/sand3.mp3"), load("res://assets/sounds/blocks/sand4.mp3")]
}

var rng = RandomNumberGenerator.new()

func play_block_place_sound(id = 1, sound_position = Vector3(0,0,0)):
	rng.randomize()
	var play_sound = preload("res://scenes/sound.tscn").instantiate()
	if sounds.has(str(id)):
		play_sound.stream = sounds[str(id)][rng.randi_range(0,3)]
	else:
		play_sound.stream = load("res://assets/sounds/blocks/stone1.mp3")
	G.world.add_child(play_sound)
	play_sound.global_position = sound_position
	play_sound.play()
