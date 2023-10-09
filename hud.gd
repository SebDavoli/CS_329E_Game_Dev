extends CanvasLayer

signal start_game

func _ready():
	$Controls.hide()

func _process(delta):
	pass
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	
	await $MessageTimer.timeout
	
	$Retry.text = "Retry?"
	$Retry.show()
	$StartButton.show()

func update_health(health):
	$HealthLabel.text = str(health)

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	$Retry.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
