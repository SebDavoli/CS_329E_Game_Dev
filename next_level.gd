extends RigidBody2D

func _ready():
	pass

func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	print("level2")
	if area.is_in_group("player"):
		get_tree().change_scene_to_file("res://level_2.tscn")
