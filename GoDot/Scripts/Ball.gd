extends RigidBody


	
func _physics_process(delta):
	var bodies = get_colliding_bodies()
	var game = get_parent()
	var sound = get_tree().get_root().get_node("Main").get_node("Audio").get_node("Sounds")
	for body in bodies:
		if body.is_in_group("Bricks"):
			sound.get_node("Box_Sound").play()
			game.set_score(100)
			body.get_parent().get_parent().explode()
			if len(get_tree().get_nodes_in_group("Bricks"))==1:
				game.won()
		else:
			sound.get_node("Wall_Sound").play()
			if len(get_tree().get_nodes_in_group("Bricks"))==0:
				game.won()
			if body.get_parent().is_in_group("Floor"):
				queue_free()
				game.loose_life()
