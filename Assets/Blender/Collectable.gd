extends Area3D

func Collect(player : PlayerController):
	get_parent().queue_free()
