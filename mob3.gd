class_name Mob3
extends RigidBody2D
@export var mob2_scene: PackedScene
var dead = false
var player = null
var player_chase = false
var speed = 100

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
	player = body
	player_chase = true 


func _on_detection_area_body_exited(body):
	player_chase = false





func _physics_process(delta):
	# Checking death condition each loop
	if dead == true:
		$AnimatedSprite2D.stop()
		#$Shadow1_DeathSprite.play("death")
		death()


	if player_chase:
		rotation = 0
		dir_vector = Vector2((player.position.x-position.x),(player.position.y-position.y))
		angle = atan2(dir_vector.y,dir_vector.x)



		if abs(dir_vector.x) > abs(dir_vector.y):
			$AnimatedSprite2D.play("horizontal")
			if (dir_vector.x) <= 0:
				scale.x = -1
			else:
				scale.x = 1

		else:
			$AnimatedSprite2D.play("vertical")
			if (dir_vector.y) <= 0:
				scale.y = -1
			else:
				scale.y = 1



		if dir_vector.length() > 10:
			# MOVEMENT AND DIRECTION CODE
			linear_velocity = dir_vector/dir_vector.length()*speed
			#look_at(player.position)
		else:
			linear_velocity = Vector2(-dir_vector.x,-dir_vector.y)*speed/2







'''
		# CHECKING IF MOB NEEDS TO REORIENTATE
		if orientation != "left" && angle <= PI/4 && angle >= -PI/4:
			$Vertical_Sprite.stop()
			$Vertical_Sprite.hide()
			$Horizontal_Sprite.play("h3")
			$Horizontal_Sprite.show()
			orientation = "left"

		elif orientation != "right" && angle >= 3*PI/4 && angle < -3*PI/4:
			$Vertical_Sprite.stop()
			$Vertical_Sprite.hide()
			$Horizontal_Sprite.play("h3")
			$Horizontal_Sprite.show()
			orientation = "right"

		elif orientation != "down" && angle >= -3*PI/4 && angle < -PI/4:
			$Vertical_Sprite.play("v3")
			$Vertical_Sprite.show()
			$Horizontal_Sprite.stop()
			$Horizontal_Sprite.hide()
			orientation = "down"

		elif orientation != "up" && angle < 3*PI/4 && angle > PI/4:
			$Vertical_Sprite.play("v3")
			$Vertical_Sprite.show()
			$Horizontal_Sprite.stop()
			$Horizontal_Sprite.hide()
			orientation = "up"
'''
















# Any 2D body the mob collides with is identified and processed here
func _on_body_entered(body):
	print(body.get_name())
	if body.get_name() == "FlashLight":
		#$Death3.play()

		$CollisionShape.visible = false
		#$Squirrel_DeathSprite.visible = true
		dead = true
		$CollisionShape.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape.set_deferred("disabled",true)


# Function for eliminating Mob instance
func death():
	#if $Squirrel_DeathSprite.frame == 3:
	hide()
	#if $Death3.playing == false:
	queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
