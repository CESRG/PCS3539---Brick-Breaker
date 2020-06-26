extends RigidBody

func _ready():
	pass
	
func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Bricks"):
			get_tree().get_root().get_node("Game").set_score(100)
			body.get_parent().queue_free()
		else: 
			if body.get_parent().is_in_group("Floor"):
				queue_free()
				get_tree().get_root().get_node("Game").loose_life()
#
#		if body.get_name() =="Player":
#			var speed = linear_velocity.length()
#			var direction = translation - body.get_child(2).translation
#			var velocity= direction.normalized()* speed
#			linear_velocity= velocity
			
			
