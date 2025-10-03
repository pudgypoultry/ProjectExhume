extends GPUParticles3D

@export var playerNode : Node3D
var lastPlayerPosition = Vector3.ZERO
var lastPlayerRotation = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = playerNode.position.x
	position.z = playerNode.position.z
	if lastPlayerPosition != playerNode.position or lastPlayerRotation != playerNode.rotation:
		position -= playerNode.transform.basis.z * 2
	lastPlayerPosition = playerNode.position
	lastPlayerRotation = playerNode.rotation
