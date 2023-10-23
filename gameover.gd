extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
