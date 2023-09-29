class_name Light
extends RigidBody2D

var velocity = Vector2(0,0)
var speed = 1000

func _ready():
	$AnimatedSprite2D.play("default")

func _process(delta):
	move_and_collide(velocity.normalized() * delta * speed)
