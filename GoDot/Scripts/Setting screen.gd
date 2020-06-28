extends Control

var settings_file = "user://settings.save"
var enable_sound = true
var enable_music = true
# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	$Menu/Music.pressed=enable_music
	$Menu/Sound.pressed=enable_sound
	for button in get_tree().get_nodes_in_group("Button"):
		button.connect("pressed",self, "_on_Button_pressed", [button.scene_to_load])
	pass # Replace with function body.

func _on_Button_pressed(new_scene):
	save_settings()
	var newScreen=load(new_scene)
	get_parent().add_child(newScreen.instance())
	queue_free()

func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(enable_sound)
	f.store_var(enable_music)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		enable_sound = f.get_var()
		enable_music = f.get_var()
		f.close()
		
func _on_Music_pressed():
	enable_music= not enable_music
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), not enable_music)

func _on_Sound_pressed():
	enable_sound= not enable_sound
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sounds"), not enable_sound)
