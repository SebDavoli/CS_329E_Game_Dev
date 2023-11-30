class_name Mob3
extends RigidBody2D
@export var mob2_scene: PackedScene
var dead = false
var pause = false
var pause_count = 0
var player = null
var player_chase = false
var speed = 125

var orientation = "right" # way the mob is facing
var quadrant # where is the mob relative to the player

var dir_vector # vector from mob to sola
var angle #angle between mob and sola

func _ready():
	# Beginning mob animation
	$AnimatedSprite2D.play("horizontal")
	$Squirrel_DeathSprite.visible = false


# Mob detecting sola collision area
func _on_detection_area_body_entered(body):
	if body.get_name() == "Sola":
		player = body
		player_chase = true 


func _on_detection_area_body_exited(body):
	if body.get_name() == "Sola":
		player_chase = false





func _physics_process(delta):
	# Checking death condition each loop
	if dead == true:
		$AnimatedSprite2D.stop()
		$Squirrel_DeathSprite.play("death")
		death()


	if player_chase:
		rotation = 0
		dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y))


		if abs(dir_vector.x) > abs(dir_vector.y):
			$AnimatedSprite2D.play("horizontal")
			$CollisionShape.rotation_degrees = 90

			if (dir_vector.x) <= 0:
				scale.x = -1
			else:
				scale.x = 1
				$CollisionShape.rotate(PI/2)

		else:
			$AnimatedSprite2D.play("vertical")
			$CollisionShape.rotation_degrees = 180

			if (dir_vector.y) <= 0:
				scale.y = -1
			else:
				scale.y = 1



		# Movement dictation
		if pause == false:
			# Far away movement
			if dir_vector.length() > 100:
				# MOVEMENT AND DIRECTION CODE
				linear_velocity = dir_vector/dir_vector.length()*speed

			# Close range - can create a variety of attacks if each attack is a function determined by random numbers
			elif dir_vector.length() > 10 && dir_vector.length() <= 100:
				linear_velocity = Vector2(0,0)
				pause = true
				$AnimatedSprite2D.stop()
				$DashTimer.start()

			# Recoil after contact with Sola
			elif dir_vector.length() <= 10:
				linear_velocity = Vector2(-dir_vector.x,-dir_vector.y)*speed/2



func _on_dash_timer_timeout():
	$AnimatedSprite2D.play()
	pause_count += 1
	dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y))
	linear_velocity = dir_vector/dir_vector.length()*speed*3
	# Second time around- unpause
	if pause_count%2 == 0:
		pause = false

	else: # first time around
		$DashTimer.start()



# Any 2D body the mob collides with is identified and processed here
func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		$Death3.play()
		Global.kill_count += 1
		$AnimatedSprite2D.visible = false
		$CollisionShape.visible = false
		$Squirrel_DeathSprite.visible = true
		dead = true
		$CollisionShape.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape.set_deferred("disabled",true)


# Function for eliminating Mob instance
func death():
	print("death is running")
	if $Squirrel_DeathSprite.frame == 4:
		hide()
		print("penis")
	if $Death3.playing == false:
		queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.



