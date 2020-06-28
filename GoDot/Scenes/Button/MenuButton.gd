extends Button

export(String) var scene_to_load

export(String) var name_label

func _ready():
	$Label.text=name_label
	add_to_group("Button")
