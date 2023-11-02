class_name Mob2
extends RigidBody2D
@export var mob2_scene: PackedScene
var dead = false
var player = null
var player_chase = false
var speed = 150
var x = 0.0

func _ready():
	# Beginning mob animation

	$AnimatedSprite2D.play("move2")
	$Shadow2_DeathSprite.visible = false
	
func _physics_process(delta):
	# NEED TO FIX WHEN DIRECTLY ON TOP OF SOLA-> ADD IF STATEMENT FOR ABS VALUE OF VECTOR
	if player_chase:
		look_at(player.position)
		var dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y))
		var vector_to_sola = dir_vector/dir_vector.length() #normalized
		
		if dir_vector.length() > 175:
			# MOVEMENT AND DIRECTION CODE
			linear_velocity = Vector2(vector_to_sola.x,vector_to_sola.y)*speed
			
		else:
			linear_velocity = Vector2(vector_to_sola.y,-vector_to_sola.x)*speed + Vector2(vector_to_sola.x,vector_to_sola.y)*0.5*speed
			
	# Checking death condition each loop
	if dead == true:
		
		$AnimatedSprite2D.stop()
		$Shadow2_DeathSprite.play("death2")
		death()
	
	# ADJUSTING X VALUE FOR FUNCTION
	x += 0.1

# Any 2D body the mob collides with is identified and processed here
func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		$Death2.play()
		print("killed")
		$AnimatedSprite2D.visible = false
		$Shadow2_DeathSprite.visible = true
		dead = true
		$CollisionShape2D.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)


# Function for eliminating Mob instance
func death():
	if $Shadow2_DeathSprite.frame == 3:
		hide()
	if $Death2.playing == false:
		queue_free()


# Mob detecting sola collision area
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true 


func _on_detection_area_body_exited(body):
	player_chase = false
