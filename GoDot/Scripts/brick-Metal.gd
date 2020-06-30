extends Spatial

const VIDA = 3
var atual = VIDA
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func explode():
	atual = atual - 1
	if(atual == 0):
		$bloco.hide()
		$Explosion.show()
		$Explosion.emitting=true
		$Explosion/ExplosionTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExplosionTimer_timeout():
	queue_free()
