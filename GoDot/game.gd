extends Spatial


var Score=0
var life=10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	life=10
	get_node("Lifes").text= "Lifes: " + str(life)
	Score=0
	get_node("Score").text= "Score: " + str(Score)
	pass # Replace with function body.

func set_score(score):
	Score+=score
	get_node("Score").text= "Score: " + str(Score)
	
func loose_life():
	life-=1
	get_node("Lifes").text= "Lifes: " + str(life)
	if life==0:
		print("Game Over")
		pass
	else:
		get_node("Player").respawn_ball()
	
	
	
	
