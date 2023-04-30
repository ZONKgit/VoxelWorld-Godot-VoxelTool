extends VoxelGeneratorScript

const channel : int = VoxelBuffer.CHANNEL_TYPE

func _get_used_channels_mask() -> int:
	return 1 << channel

var height_noise := FastNoiseLite.new()
var biome_noise := FastNoiseLite.new()
var river_noise := FastNoiseLite.new()
var rng = RandomNumberGenerator.new()

func _ready():
	var noise_seed = rng.randf_range(1, 1000)
	height_noise.seed = noise_seed
	biome_noise.seed = noise_seed
	rng.randomize()
	
	# Настройка шума воды
	river_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	river_noise.fractal_type = FastNoiseLite.FRACTAL_PING_PONG
	river_noise.fractal_octaves = 1
	river_noise.frequency = 0.195




func _generate_block(buffer : VoxelBuffer, origin : Vector3i, lod : int) -> void:
	if lod != 0:
		return
	
	
	if origin.y == 0:
		for x in range(16):
			for y in range(16):
				for z in range(16):
					if y < height_noise.get_noise_2d(x+origin.x,z+origin.z)*5+10:

						#Равнины
						if biome_noise.get_noise_2d(x+origin.x,z+origin.z)*15 < 5 && biome_noise.get_noise_2d(x+origin.x,z+origin.z)*15 > 1: # Равнины
							buffer.set_voxel(1, x,y,z)
							if rng.randi_range(1, 15) == 1: # Трава
								buffer.set_voxel(2, x,y+1,z)

						# Горы
						if biome_noise.get_noise_2d(x+origin.x,z+origin.z)*15 > 5: # Горы
							buffer.set_voxel(5,x,y+2,z)

							# Пустыни
						if biome_noise.get_noise_2d(x+origin.x,z+origin.z)*15 < 1: # Пустыни
							buffer.set_voxel(6, x,y,z)

