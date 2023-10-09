class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene

func _ready():
	$AnimatedSprite2D.play("move")
	$Spawn.play()

func _physics_process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("light"):
		linear_velocity = Vector2(0, 0)
		$Death.play()
		$CollisionShape2D.set_deferred("disabled",true)

func handle_hit():
	print("enemy hit")


func _on_death_finished():
	queue_free()
	hide()
