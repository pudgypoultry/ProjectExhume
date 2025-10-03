extends Node3D

@export var toothArray : Array[Node3D]
@export var goldToothArray : Array[Node3D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ChooseTeeth(false)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func ChooseTeeth(repeated : bool):
	if !repeated:
		var randomValue = randi_range(0,9)
		if 0 <= randomValue and randomValue <= 5:
			toothArray[randomValue].visible = false
			goldToothArray[randomValue].visible = true
		elif 6 <= randomValue and randomValue <= 8:
			pass
		else:
			ChooseTeeth(true)
	else:
		var randomValue1 = randi_range(0,5)
		var randomValue2 = randi_range(0,5)
		while randomValue2 == randomValue1:
			randomValue2 = randi_range(0,5)
		toothArray[randomValue1].visible = false
		goldToothArray[randomValue1].visible = true
		toothArray[randomValue2].visible = false
		goldToothArray[randomValue2].visible = true
