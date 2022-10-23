extends Spatial

export(String, "Red", "Blue", "Purple", "none") var color_tag
export(String, "x", "y", "z") var spin_axis
export var spin_speed = 1

onready var main_game = get_node("/root/MainGame")

func _ready():
	if color_tag == "Blue":
		spin_speed *= -1
	set_color()

	

func _process(delta):
	if main_game.active_color == color_tag or main_game.active_color == "Purple":
		if spin_axis == "x":
			rotate_object_local(Vector3(1, 0 ,0), spin_speed * delta)
		if spin_axis == "y":
			rotate_object_local(Vector3(0, 1 ,0), spin_speed * delta)
		if spin_axis == "z":
			rotate_object_local(Vector3(0, 0 ,1), spin_speed * delta)
	

func set_color():
	if color_tag == "none":
		pass
	else:
		for i in $Models.get_children():
			i.set_surface_material(0, load(str("res://", str(color_tag), "Platform.tres")))
	

