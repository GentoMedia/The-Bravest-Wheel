extends KinematicBody

onready var main_game = get_node("/root/MainGame")

export var speed = 100
export var rot_speed = 16
export var gravity = 20
export var jump_speed = 10
export var spin_speed = 1
export var mouse_sensitivity = 0.01

var player_rotate
var camera
var world
var movement


func _ready():
	main_game.player = self
	player_rotate = $Model
	camera = $CameraRotate
	world = get_parent()
	movement = Vector3.ZERO
	get_parent().get_node("Goal").player = self
	
func _physics_process(delta):
	move_player(delta)
	camera_rot(delta)

func move_player(delta):
	movement *= Vector3(0, 1, 0)
	var snap = Vector3.DOWN
	var horizontal = Input.get_action_strength("left") - Input.get_action_strength("right")
	var vertical = Input.get_action_strength("forward") - Input.get_action_strength("backward")
	var direction = Vector3(horizontal, 0, vertical)
	direction = direction.rotated(Vector3(0, 1, 0), camera.rotation.y)
	
	if direction != Vector3.ZERO:
		player_rotate.look_at(player_rotate.global_transform.origin + direction.normalized(), Vector3.UP)
		player_rotate.get_node("Spatial").rotate_x((abs(direction.x) + abs(direction.z)) * -spin_speed / 2 )
	
	if is_on_floor():
		movement.y = 0
		
		if Input.is_action_just_pressed("B"):
			movement.y = jump_speed
			snap = Vector3.ZERO
			$AudioStreamPlayer.play()
			
	movement += direction * speed
	movement.y -= gravity * delta
	
	move_and_slide_with_snap(movement, snap, Vector3.UP)
	if movement.y < -gravity * 2:
		main_game.falls += 1
		get_tree().reload_current_scene()
		get_node("/root/LoseSound").play()
		main_game.active_color = null


func camera_rot(delta):
	var rot_control = Input.get_action_strength("rot_left") - Input.get_action_strength("rot_right")
	camera.rotate_y(rot_control * rot_speed * delta)


func _input(event):
	if event is InputEventMouseMotion:
		camera.rotate_y(-event.relative.x * mouse_sensitivity)
	
