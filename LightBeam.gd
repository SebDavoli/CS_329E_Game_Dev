class_name Light
extends RigidBody2D

var velocity = Vector2(0,0)
var speed = 1000

func _ready():
	$AnimatedSprite2D.play("default")
	$AnimatedSprite2D.flip_v = false

func _process(delta):
	move_and_collide(velocity.normalized() * delta * speed)

func _on_body_entered(body: Node):
	if body.has_method("handle_hit"):
		body.handle_hit
		get_tree().call_group("light", "queue_free")
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
