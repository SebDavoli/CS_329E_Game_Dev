extends CanvasLayer

signal start_game

func _ready():
	pass

func _process(delta):
	pass
	
func show_message(text):
	pass
	
func show_game_over():
	pass
#	show_message("Game Over")
#
#	$Retry.text = "Retry?"
#	$Retry.show()
#	$StartButton.show()

func update_health(health):
	$HealthLabel.text = str(health)
	
	if health >= 100:
		$Health.texture = ResourceLoader.load("res://Art/Health Bar (100).png")
	if health == 80:
		$Health.texture = ResourceLoader.load("res://Art/Health Bar (80).png")
	if health == 60:
		$Health.texture = ResourceLoader.load("res://Art/Health Bar (60).png")
	if health == 40:
		$Health.texture = ResourceLoader.load("res://Art/Health Bar (40).png")
	if health == 20:
		$Health.texture = ResourceLoader.load("res://Art/Health Bar (20).png")
	if health == 0:
		$Health.texture = ResourceLoader.load("res://Art/Health Bar (0).png")	

func update_charge(charge):
	if charge == 5:
		$Charge.texture = ResourceLoader.load("res://Art/Charge 5.png")
	if charge < 4:
		$Charge.texture = ResourceLoader.load("res://Art/Charge 4.png")
	if charge < 3:
		$Charge.texture = ResourceLoader.load("res://Art/Charge 3.png")
	if charge < 2:
		$Charge.texture = ResourceLoader.load("res://Art/Charge 2.png")
	if charge < 1:
		$Charge.texture = ResourceLoader.load("res://Art/Charge 1.png")
	if charge == 0:
		$Charge.texture = ResourceLoader.load("res://Art/Charge 0.png")

#func _on_start_button_pressed():
#	$StartButton.hide()
#	$Message.hide()
#	$Retry.hide()
#	start_game.emit()

func _on_message_timer_timeout():
	pass
