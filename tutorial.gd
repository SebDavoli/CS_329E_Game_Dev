extends Node2D

var timer= 2.5
var count_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	count_down = true
	$Sola.camera = $Sola/Camera2D
	$Sola.start($StartPosition.position)
	$BGM.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if count_down==true:
		timer -= 1 * delta
	
	if timer <= 0:
		$CanvasLayer/Fade.modulate.a -= 1*delta
		$CanvasLayer/Message.modulate.a -= 1*delta
		$CanvasLayer/Controls.modulate.a += 1*delta

