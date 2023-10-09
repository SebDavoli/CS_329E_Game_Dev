class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene

#var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	get_parent().get_node("Sola")
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	print(str(body))
	if body is Light:
		queue_free()
		hide()
		$CollisionShape2D.set_deferred("disabled",true)
