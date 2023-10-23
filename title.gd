extends Node2D

var timer= 2.5
var count_down = false

func _ready():
	$CanvasLayer.hide()

func _on_start_button_pressed():
	$CanvasLayer.show()
	$CanvasLayer/AnimationPlayer.play("fade")
	count_down = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if count_down==true:
		timer -= 1 * delta
	
	if timer <= 0:
		get_tree().change_scene_to_file("res://tutorial.tscn")
