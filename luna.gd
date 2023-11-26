class_name Luna
extends RigidBody2D
@export var Luna_scene: PackedScene
var dead = false
var pause = false
var pause_count = 0
var player = null
var player_chase = false
var dir_vector
var speed = 100
var x = 0.0

func _ready():
	# Beginning mob animation
	$AnimatedSprite2D.play("move4")
	$LunaDeathSprite.visible = false

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
		#$Shadow1_DeathSprite.play("death")
		death()


	if player_chase:
		rotation = 0 #Luna does not rotate
		dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y)) # vector between luna and sola

		# Sprite Orientation based on movement direction
		if abs(dir_vector.x) > abs(dir_vector.y):
			$AnimatedSprite2D.play("horizontal")
			if (dir_vector.x) <= 0:
				scale.x = -1
			else:
				scale.x = 1
		else:
			$AnimatedSprite2D.play("vertical")


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
				$DashTimer.start()

			# Recoil after contact with Sola
			elif dir_vector.length() <= 10:
				linear_velocity = Vector2(-dir_vector.x,-dir_vector.y)*speed/2


# Dash attack activation
func _on_dash_timer_timeout():
	pause_count += 1
	dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y))
	print(dir_vector)
	linear_velocity = dir_vector/dir_vector.length()*speed*4
	if pause_count%2 == 0:
		pause = false
	else: # second time round
		$DashTimer.start()




# Any 2D body the mob collides with is identified and processed here
func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		#$DeathLuna.play()
		print("killed")
		Global.kill_count += 1
		$AnimatedSprite2D.visible = false
		$LunaDeathSprite.visible = true
		dead = true
		$CollisionShape2D.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)


# Function for eliminating Mob instance
func death():
	#if $LunaDeathSprite.frame == 3:
	hide()
	#if $Death2.playing == false:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.



