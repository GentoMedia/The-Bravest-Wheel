extends Spatial

onready var speed = rand_range(-1, 1)

func _process(delta):
	rotate_y(speed * delta)
