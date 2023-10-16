class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene

func _ready():
	$AnimatedSprite2D.play("move")

func _physics_process(delta):
	pass

func _on_body_entered(body):
<<<<<<< Updated upstream
	if body.is_in_group("light"):
		queue_free()
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$Death.play()
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)
=======
	if body.name == "FlashLight":
		$Death.play()
		await 
		print("help")
		queue_free()
		hide()
		$CollisionShape2D.set_deferred("disabled",true)

func handle_hit():
	print("enemy hit")


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
>>>>>>> Stashed changes
