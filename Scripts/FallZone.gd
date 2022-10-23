extends Area

onready var main_game = get_node("/root/MainGame")


func _on_FallZone_body_entered(body):
	if body.name == "Player":
		main_game.falls += 1
		get_tree().reload_current_scene()
		get_node("/root/LoseSound").play()
		main_game.active_color = null
