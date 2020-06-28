extends Spatial

var settings_file = "user://settings.save"
var enable_sound = true
var enable_music = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var mainScreen=load("res://Scenes/MenuScreens/Main Screen.tscn")
	add_child(mainScreen.instance())
	load_settings()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), not enable_music)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Sounds"), not enable_sound)
	pass
	
func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		enable_sound = f.get_var()
		enable_music = f.get_var()
		f.close()
		

