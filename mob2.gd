class_name Mob2
extends RigidBody2D
@export var mob2_scene: PackedScene

func _ready():
	$AnimatedSprite2D.play("move2")

func _physics_process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		queue_free()
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$Death.play()
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)

