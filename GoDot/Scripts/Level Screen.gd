extends Control

var listitem = preload("res://Scenes/Objects/LevelCard.tscn")
var settings_file = "user://level.save"
var maxLevel = 1

func _ready():
	load_level()
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed",self, "_on_Button_pressed", [button.scene_to_load])
	for i in range(9):
		addItem(i)
		
func _on_Button_pressed(scene_to_load):
	var newScreen=load(scene_to_load)
	print(scene_to_load)
	get_parent().add_child(newScreen.instance())
	queue_free()
	
func load_level():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		maxLevel = f.get_var()
		f.close()
		
func addItem(idx):
	var item=listitem.instance()
	var value= "Level " + str(idx+1)
	item.get_node("Label").text=value
	if maxLevel<idx:
		item.get_node("Button").disabled=true
		item.get_node("ColorRect").color=Color(0,0,0)
	$Menu/Panel/Levels/List.add_child(item)
