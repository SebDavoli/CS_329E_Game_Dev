class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene

func _ready():
	$AnimatedSprite2D.play("move")

func _physics_process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("light"):
		queue_free()
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
		$Death.play()
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)
