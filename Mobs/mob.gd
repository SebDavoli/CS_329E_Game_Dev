class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene
var dead = false

func _ready():
	# Beginning mob animation
	$AnimatedSprite2D.play("move")
	$Shadow1_DeathSprite.visible = false

func _physics_process(delta):
	# Checking death condition each loop
	if dead == true:
		$AnimatedSprite2D.stop()
		$Shadow1_DeathSprite.play("death")
		death()


func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		$AnimatedSprite2D.visible = false
		$Shadow1_DeathSprite.visible = true
		dead = true
		$CollisionShape2D.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)

# Function for eliminating Mob instance
func death():
	if $Shadow1_DeathSprite.frame == 3:
		print("death function")
		queue_free()
		hide()

