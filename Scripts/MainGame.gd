extends Node

var active_color
var time
var falls
var win_condition

var player

signal paused
signal game_win

func _ready():
	main_reset()
	self.set_pause_mode(2)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	randomize()
	

func _process(delta):
	if Input.is_action_just_pressed("menu"):
		pause_game()
		

func pause_game():
	if !win_condition:
		get_tree().paused = !get_tree().paused
		emit_signal("paused")
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		pass
	

func main_reset():
	active_color = null
	time = 0
	falls = 0
	win_condition = false
	

func level_select(level : String):
	get_tree().change_scene(level)
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	main_reset()
	

func win_game():
	emit_signal("game_win")
	player.set_physics_process(false)
	player.set_process_input(false)
	win_condition = true
	
