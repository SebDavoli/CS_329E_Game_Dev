extends Node2D

var timer= 2.5
var count_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	count_down = true
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true
	$Sola.camera = $Sola/Camera2D
	$Sola.start($StartPosition.position)
	$BGM.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($Sola/FlashLight/CollisionPolygon2D.disabled)
	if count_down==true:
		timer -= 1 * delta
	
	if $FlashTimer.get_time_left() > 0:
		$Sola/FlashLight/CollisionPolygon2D.disabled = false
	
	if timer <= 0:
		$CanvasLayer/Fade.modulate.a -= 1*delta
		$CanvasLayer/Message.modulate.a -= 1*delta
		$CanvasLayer/Controls.modulate.a += 1*delta

func _on_flash_timer_timeout():
	print("Flahslight off")
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true

func shine():
	$Flashlight.hide()
	$Flashlight/CollisionShape2D.disabled = true
	$Sola/FlashLight.show()
	print("Flashlight ON")
	$FlashTimer.start()	
