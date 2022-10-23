extends Control

onready var main_game = get_node("/root/MainGame")


func _ready():
	main_game.connect("paused", self, "_on_pause")
	main_game.connect("game_win", self, "_on_win")
	set_labels()
	$Menu.visible = false
	for i in $Menu.get_children():
		if i is Button:
			i.disabled = true


func _on_Timer_timeout():
	main_game.time += 1
	set_labels()

func set_labels():
	$FallsContainer/Falls.text = str(main_game.falls)
	$TimeContainer/Time.text = str(main_game.time)
	
func _on_pause():
	$Menu/Title.text = "The Bravest Wheel"
	$Menu.visible = get_tree().paused
	for i in $Menu.get_children():
		if i is Button:
			i.disabled = !get_tree().paused
	if $Menu.visible:
		$Menu/Level1.grab_focus()


func _on_Quit_pressed():
	get_tree().quit()


func _on_Level1_pressed():
	main_game.level_select("res://LevelScenes/Level1.tscn")


func _on_Level3_pressed():
	main_game.level_select("res://LevelScenes/Test.tscn")

func _on_win():
	$Menu/Title.text = "Nice!"
	$Menu.visible = true
	for i in $Menu.get_children():
		if i is Button:
			i.disabled = false
	if $Menu.visible:
		$Menu/Level1.grab_focus()
	$Timer.stop()
	
