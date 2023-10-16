class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene

func _ready():
	$AnimatedSprite2D.play("move")

func _physics_process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	$Death.play()
	if body.is_in_group("light"):
		print("help")
		queue_free()
		hide()
		$CollisionShape2D.set_deferred("disabled",true)

func handle_hit():
	print("enemy hit")
