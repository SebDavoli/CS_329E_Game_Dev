extends RigidBody2D
@export var mob_scene: PackedScene

#var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
