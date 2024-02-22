extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print("sundae eaten")
	print(body.get_name())
	if body.get_name() == "Sola":
		$Sprite2D.visible = false
		$CollisionShape2D.set_deferred("disabled",true)
