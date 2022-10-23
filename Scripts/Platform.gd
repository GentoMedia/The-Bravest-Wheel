extends Spatial

export(String, "Red", "Blue", "Purple", "none") var color_tag
export var rotation_speed = 1

var main_game


func _ready():
	main_game = get_node("/root/MainGame")
	add_to_group(color_tag)
	if color_tag == "Blue":
		rotation_speed *= -1
	set_color()

func _physics_process(delta):
	if main_game.active_color == color_tag or main_game.active_color == "Purple":
		rotate_object_local(Vector3(0, 1 ,0), rotation_speed * delta)


func _on_Area_body_entered(body):
	if body.name == "Player":
		main_game.active_color = color_tag


func _on_Area_body_exited(body):
	if body.name == "Player":
		main_game.active_color = null
	#pass


func set_color():
	if color_tag == "none":
		pass
	else:
		var platform_base = $BasePlatform/MeshInstance
		var meshMaterial = load(str("res://", str(color_tag), "Platform.tres"))
		
		platform_base.set_surface_material(3, meshMaterial)
		platform_base.set_surface_material(4, meshMaterial)
		
		var platform_switches = [$Platform1/MeshInstance, $Platform2/MeshInstance, $Platform3/MeshInstance]
		for i in platform_switches:
			i.set_surface_material(2, meshMaterial)

	
