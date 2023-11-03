class_name Mob3
extends RigidBody2D
@export var mob2_scene: PackedScene
var dead = false
var player = null
var player_chase = false
var speed = 150
var x = 0.0

func _ready():
	# Beginning mob animation
	$AnimatedSprite2D.play("move3")
	$Squirrel_DeathSprite.visible = false
	
func _physics_process(delta):
	if player_chase:
		var dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y))
		if dir_vector.length() > 30:
			# MOVEMENT AND DIRECTION CODE
			linear_velocity = dir_vector/dir_vector.length()*speed
			look_at(player.position)
		else:
			linear_velocity = Vector2(-dir_vector.x,-dir_vector.y)*speed/2
	# Checking death condition each loop
	if dead == true:
		$AnimatedSprite2D.stop()
		$Shadow1_DeathSprite.play("death")
		death()
	
	# ADJUSTING X VALUE FOR FUNCTION
	x += 0.1

# Any 2D body the mob collides with is identified and processed here
func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		$Death3.play()
		print("killed")
		$AnimatedSprite2D.visible = false
		$Squirrel_DeathSprite.visible = true
		dead = true
		$CollisionShape2D.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)


# Function for eliminating Mob instance
func death():
	if $Squirrel_DeathSprite.frame == 3:
		hide()
	if $Death3.playing == false:
		queue_free()


# Mob detecting sola collision area
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true 


func _on_detection_area_body_exited(body):
	player_chase = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
