extends Node2D

func _ready():
	$Scream.play()

func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://title.tscn")


func _on_retry_button_2_pressed():
	if Global.current_level == 1:
		get_tree().change_scene_to_file("res://level_1.tscn")
	elif Global.current_level == 2:
		get_tree().change_scene_to_file("res://level_2.tscn")
	elif Global.current_level == 3:
		get_tree().change_scene_to_file("res://level_3.tscn")
	else:
		get_tree().change_scene_to_file("res://title.tscn")
