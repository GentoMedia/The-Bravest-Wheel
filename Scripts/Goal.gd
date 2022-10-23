extends Spatial

onready var main_game = get_node("/root/MainGame")
var player


func _on_Area_body_entered(body):
	if body.name == "Player":
		main_game.active_color = "Purple"
		main_game.win_game()
	
