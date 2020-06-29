extends Control

var _Level=0
# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed",self, "_on_Button_pressed", [button.scene_to_load])
		

func _on_Button_pressed(scene_to_load):
	print(scene_to_load)
	if "game" in scene_to_load:
		get_parent().get_node("Game").loadLevel(_Level)
	else:
		var newScreen=load(scene_to_load).instance()
		get_parent().add_child(newScreen)
	queue_free()

func setLevel(level):
	_Level=level
