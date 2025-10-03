extends CharacterBody3D

class_name PlayerController

@export var cam : Camera3D
@export var camSpeedX : float = 1.0
@export var camSpeedY : float = 1.0
@export var verticalCameraClamp : float = 30.0

@export var voxelTerrain : VoxelLodTerrain
@export var digRay : RayCast3D
@export var digMarker : Node3D

@onready
var voxelTool : VoxelTool = voxelTerrain.get_voxel_tool()

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var cameraX : float
var cameraY : float
var tryingToDig : bool = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		ShowMouse()
	if Input.is_action_pressed("Dig"):
		tryingToDig = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	Dig()
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	Rotation(event)


func Rotation(event):
	if event is InputEventMouseMotion:
			cameraX -= deg_to_rad(camSpeedX * event.relative.x)
			cameraY -= deg_to_rad(camSpeedY * event.relative.y)
			cameraY = clampf(cameraY, -deg_to_rad(verticalCameraClamp), deg_to_rad(verticalCameraClamp))
			cam.set_rotation(Vector3(cameraY, cam.rotation.y, cam.rotation.z))
			set_rotation(Vector3(rotation.x, cameraX, rotation.z))


func Dig():
	if tryingToDig && digRay.is_colliding():
		voxelTool.mode = VoxelTool.MODE_REMOVE
		voxelTool.do_sphere(digRay.get_collision_point(), 2.0)
		tryingToDig = false
	elif tryingToDig && !digRay.is_colliding():
		voxelTool.mode = VoxelTool.MODE_REMOVE
		voxelTool.do_sphere(digMarker.global_position, 2.0)
		tryingToDig = false


func ShowMouse():
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
