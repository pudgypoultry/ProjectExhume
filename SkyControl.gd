extends WorldEnvironment

@export var thunderSound : AudioStreamPlayer
@export var thunderSoundAsset : AudioStreamMP3
@export var rainSound : AudioStreamPlayer

var skyShader : ShaderMaterial
var originalTopColor : Color
var originalBottomColor : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skyShader = environment.sky.sky_material
	originalTopColor = skyShader.get_shader_parameter("top_color")
	originalBottomColor = skyShader.get_shader_parameter("bottom_color")
	rainSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("DebugTest"):
		LightningStrike()
		pass

func LightningStrike():
	skyShader.set_shader_parameter("top_color", Vector4(1.0, 1.0, 1.0, 1.0))
	skyShader.set_shader_parameter("bottom_color", Vector4(1.0, 1.0, 1.0, 1.0))
	await get_tree().create_timer(randf_range(0.025, 0.075)).timeout
	skyShader.set_shader_parameter("top_color", originalTopColor)
	skyShader.set_shader_parameter("bottom_color", originalBottomColor)
	await get_tree().create_timer(randf_range(0.075, 0.125)).timeout
	skyShader.set_shader_parameter("top_color", Vector4(1.0, 1.0, 1.0, 1.0))
	skyShader.set_shader_parameter("bottom_color", Vector4(1.0, 1.0, 1.0, 1.0))
	await get_tree().create_timer(randf_range(0.1, 0.2)).timeout
	skyShader.set_shader_parameter("top_color", originalTopColor)
	skyShader.set_shader_parameter("bottom_color", originalBottomColor)
	await get_tree().create_timer(randf_range(0.1, 0.5)).timeout
	thunderSound.play()
