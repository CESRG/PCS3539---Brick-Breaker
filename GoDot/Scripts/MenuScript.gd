extends Control

var scene_loading

func _ready():
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed",self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	scene_loading=scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	

func _on_FadeIn_fade_in_finished():
	print(scene_loading)
	var newScreen=load(scene_loading)
	get_parent().add_child(newScreen.instance())
	queue_free()
