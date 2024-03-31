extends Node2D

func _ready():
	$Scream.play()

func _process(delta):
	var format_kill_count = "%04d" % Global.kill_count
	$Score.text = "Score: " + str(format_kill_count)
	if Global.high_score < Global.kill_count:
		Global.high_score = Global.kill_count
	var format_high_score = "%04d" % Global.high_score
	$HighScore.text = "High Score: " + str(format_high_score)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://endless.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://title.tscn")
