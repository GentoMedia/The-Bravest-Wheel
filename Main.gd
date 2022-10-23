extends Spatial

onready var main_game = get_node("/root/MainGame")


func _process(delta):
	main_game.pause_game()
	main_game.active_color = "Purple"
