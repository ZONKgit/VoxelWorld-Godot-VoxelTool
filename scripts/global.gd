extends Node


var world = null #                                                               (World)

var voxel_terrain = null # Воксельный ладшафт (VoxelTerrain)                       (World)
var voxel_tool = null #voxel_tool вщксельного ладшафта (VoxelTool.get_voxel_tool())  (World)

var _cursor = null #Курсор выделения вокселя при наведение на него                      (World)


# Called every frame. 'delta' is the elapsed time since the previous frame.
