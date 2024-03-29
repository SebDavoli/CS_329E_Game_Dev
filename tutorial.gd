extends Node2D

var timer= 2.5
var count_down = false
var initial_dialogue_loaded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	count_down = true
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true
	$Sola.camera = $Sola/Camera2D
	$Sola.start($StartPosition.position)
	$BGM.play()
	$DialogueBox.hide_dialogue()
	$Sola.movement_disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($Sola/FlashLight/CollisionPolygon2D.disabled)
	print($FlashTimer.get_time_left())
	if count_down==true:
		timer -= 1 * delta
	
	if $FlashTimer.get_time_left() > 0:
		$Sola/FlashLight/CollisionPolygon2D.disabled = false
	
	if timer <= 0:
		$CanvasLayer/Fade.modulate.a -= 1*delta
		$CanvasLayer/Message.modulate.a -= 1*delta
		if $DialogueBox.executing == -1:
			if !initial_dialogue_loaded:
				$DialogueBox.load_dialogue(["Luna! Where are you!? Please be safe..", "Is that a flashlight? Could this protect me from the monsters?"])
				initial_dialogue_loaded = true
			else: 
				$Sola.movement_disabled = false	

func _on_flash_timer_timeout():
	print("Flahslight off")
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true

func shine():
	$Flashlight.hide()
	$Flashlight/CollisionShape2D.disabled = true
	$Sola/FlashLight.show()
	print("Flashlight ON")
	$Sola/FlashLight/CollisionPolygon2D.disabled = false
	$FlashTimer.start()
	$FlashTimer.paused = true

func flicker():
	$FlashTimer.paused = false
	
func mobdead():
	$Sola/Camera2D/CanvasLayer/TextureRect.hide()
	$DialogueBox.load_dialogue(["What was that?!", "I guess light does kill the monsters!", "I think I can recharge them through the lamps as well."])
