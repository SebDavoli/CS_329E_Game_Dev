class_name Mob
extends RigidBody2D
@export var mob_scene: PackedScene
var dead = false
var player = null
var player_chase = false
var speed = randi_range(100,150)
signal doom
var drop = 0.5
var rand_num
var drop_occurred = false

func _ready():
	# Beginning mob animation
	$AnimatedSprite2D.play("move")
	$Shadow1_DeathSprite.visible = false

# Mob detecting sola collision area
func _on_detection_area_body_entered(body):
	if body.get_name() == "Sola":
		player = body
		player_chase = true 


func _on_detection_area_body_exited(body):
	if body.get_name() == "Sola":
		player_chase = false


func _physics_process(delta):
	print(speed)
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
		doom.emit()
		$AnimatedSprite2D.stop()
		$Shadow1_DeathSprite.play("death")
		death()
	


func _on_body_entered(body):
	#print("Mob:")
	#print(body.get_name())
	if body.get_name() == "Sola":
		$Death.play()
		$AnimatedSprite2D.visible = false
		$Shadow1_DeathSprite.visible = true
		drop_occurred = true
		dead = true
		$CollisionShape2D.set_deferred("disabled",true)
	if body.get_name() == "FlashLight":
		$Death.play()
		$AnimatedSprite2D.visible = false
		$Shadow1_DeathSprite.visible = true
		Global.kill_count += 1
		dead = true
		
		$CollisionShape2D.set_deferred("disabled",true)
		
	if body.is_in_group("monster_bounds"):
		queue_free()
		$CollisionShape2D.set_deferred("disabled",true)

# Function for eliminating Mob instance
func death():
	if not drop_occurred:
		rand_num = randf() * 100.0
		if rand_num <= drop:
			#print("sundae created")
			var sundae = preload("res://sundae.tscn").instantiate()
			sundae.position = self.position
			get_parent().add_child(sundae)
			drop_occurred = true  # Set the flag to prevent further drops
	if $Shadow1_DeathSprite.frame == 3:
		hide()
	if $Death.playing == false:
		queue_free()
