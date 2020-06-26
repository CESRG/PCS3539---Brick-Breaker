extends KinematicBody


# Declare member variables here. Examples:
var speed= 400
var direction = Vector3()
const ball_res = preload("res://Ball.tscn")
var ball

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true) 
	respawn_ball()
	pass # Replace with function body.

func _input(ev):
	
	if Input.is_key_pressed(KEY_SPACE):
		shoot()
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().reload_current_scene()

func _physics_process(delta):
	direction=Vector3()
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_up"):
		direction.z = -1
	if Input.is_action_pressed("ui_down"):
		direction.z = 1
	direction.normalized()
	move_and_slide(direction*speed*delta,Vector3(0,1,0))
	
func respawn_ball():
	ball=ball_res.instance()
	add_child(ball)
	ball.transform.origin = Vector3(0,2,0)
	
	
func shoot():
	if ball == null:
		return
	print("Shooting")
	remove_child(ball)
	var pos= transform.origin + ball.transform.origin
	print(pos)
	ball.transform.origin=pos
	ball.set_linear_velocity(Vector3(0,10,0))
	get_tree().get_root().get_node("Game").add_child(ball)
	ball=null
	#ball.set_linear_velocity(Vector3(0,-1,0))
