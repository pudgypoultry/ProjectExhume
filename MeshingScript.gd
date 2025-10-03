@tool
extends VoxelLodTerrain


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture1 = preload("res://Assets/Grass.png").get_image()
	var texture2 = preload("res://Assets/Soil.png").get_image()
	var texture3 = preload("res://Assets/Grass.png").get_image()
	
	var texture_2d_array = Texture2DArray.new()
	texture_2d_array.create_from_images([texture1, texture2, texture3])
	
	material.set("shader_parameter/u_texture_array", texture_2d_array)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
