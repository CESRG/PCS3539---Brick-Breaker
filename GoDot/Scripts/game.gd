extends Spatial


var Score=0
var life=10
var settings_file = "user://level.save"
var levelIndex =0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_score(score):
	Score+=score
	$Header/Score.text= "Score: " + str(Score)
	
func loose_life():
	life-=1
	$Header/Lifes.text= "Lifes: " + str(life)
	if life==0:
		var newScreen=load("res://Scenes/MenuScreens/Lost Screen.tscn")
		var new =newScreen.instance()
		new.setLevel(levelIndex)
		get_parent().add_child(new)
	else:
		get_node("Player").respawn_ball()
		
func won():
	remove_child(get_node("Ball"))
	var maxLevel=load_settings()
	if levelIndex>=maxLevel:
		save_settings()
	var newScreen=load("res://Scenes/MenuScreens/Win Screen.tscn")
	var new =newScreen.instance()
	new.setLevel(levelIndex)
	get_parent().add_child(new)
	
	
func loadLevel(idx):
	levelIndex=idx
	$Header/Level.text= "Level: " + str(levelIndex + 1)
	Score=0
	$Header/Score.text= "Score: " + str(Score)
	var file = File.new()
	file.open("res://Levels/LevelPack1.json", file.READ)
	var text = file.get_as_text()
	var result_json = JSON.parse(text)
	var result = {}
	if result_json.error == OK:  # If parse OK
		var data = result_json.result
		life=int(data["Levels"][idx]["Lifes"])
		$Header/Lifes.text= "Lifes: " + str(life)
		for i in range(0, $Bricks.get_child_count()):
			$Bricks.get_child(i).queue_free()
		for box in data["Levels"][idx]["Boxes"]:
			var type = ""
			if (box["Type"] == 1):
				type = "res://Scenes/Objects/pedra.tscn"	
			elif(box["Type"] == 2):
				type = "res://Scenes/Objects/Metal.tscn"
			else:
				type = "res://Scenes/Objects/brick.tscn"
					
			var brick= load(type).instance()
			brick.transform.origin= Vector3(box["X"],box["Y"],box["Z"])
			$Bricks.add_child(brick)
		get_node("Player").respawn_ball()
	else:  # If parse has errors
		print("Error: ", result_json.error)
		print("Error Line: ", result_json.error_line)
		print("Error String: ", result_json.error_string)
	file.close()
	pass
	
func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(levelIndex + 1)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		var idx = f.get_var()
		f.close()
		return idx
	return 0
