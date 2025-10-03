extends Node3D

@export var coffinLid : Node3D
@export var stage : int = 0
@export var pointFolder1 : Node3D
@export var pointFolder2 : Node3D

func _process(delta: float) -> void:
	coffinLid.lidStage = stage
	if Input.is_action_just_pressed("DebugTest"):
		Interact(get_parent().find_child("Player"))

func Interact(player : PlayerController):
	var voxelTerrain = player.voxelTerrain
	var voxelTool = voxelTerrain.get_voxel_tool()
	voxelTool.mode = VoxelTool.MODE_REMOVE
	for point in pointFolder1.get_children():
		voxelTool.do_sphere(point.global_position, 0.25)
	for point in pointFolder2.get_children():
		voxelTool.do_sphere(point.global_position, 0.75)
