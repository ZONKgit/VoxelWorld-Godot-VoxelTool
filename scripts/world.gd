extends Node3D


# Get the terrain
var biome_noise = null

# Called when the node enters the scene tree for the first time.
func _ready():
	const terrain_generation = preload("res://scripts/terrain_generator.gd")
	var terrain = $terrain
	terrain.generator = terrain_generation.new()
	
	G.voxel_terrain = terrain
	G.voxel_tool = G.voxel_terrain.get_voxel_tool()
	G._cursor = $terrain/cursor
	G.world = self
