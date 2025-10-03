@tool
extends Node3D

@export var lidStage = 0
@export var planksFirstStage : Array[Node3D]
@export var planksSecondStage : Array[Node3D]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match lidStage:
		0:
			Appear(planksFirstStage)
			Appear(planksSecondStage)
		1:
			Disappear(planksFirstStage)
			Appear(planksSecondStage)
		2:
			Disappear(planksFirstStage)
			Disappear(planksSecondStage)


func Appear(planks : Array[Node3D]):
	for plank in planks:
		plank.visible = true

func Disappear(planks : Array[Node3D]):
	for plank in planks:
		plank.visible = false
