extends Node2D
var health
var num_mob1 = 0
var num_mob2 = 0
var rand_num

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	$LightTimer.start()
	$Sola2.start($StartPosition.position)
	$StartTimer.start()
	$FlashTimer.start()

	$BGM.play()
	$Next_Level.show()
	$Sola2.camera = $Sola2/Camera2D
	$HUD.update_health(health)
	
	#lamp disabled at start of the game
	rand_num = randi() % 8 + 1
#	$Lamps/Lamp/LampLight.hide()
#	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp2/LampLight.hide()
#	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp3/LampLight.hide()
#	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp4/LampLight.hide()
#	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp5/LampLight.hide()
#	$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp6/LampLight.hide()
#	$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp7/LampLight.hide()
#	$Lamps/Lamp7/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp8/LampLight.hide()
#	$Lamps/Lamp8/LampLight/CollisionPolygon2D.disabled = true
	
func _process(delta):
	if num_mob1 == 11:
		$Fence.hide()
		$Fence/CollisionShape2D.disabled = true
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$BGM.stop()
	$HUD.show_game_over()
	
func new_game():
	pass
#	get_tree().call_group("mobs", "queue_free")

func change_health():
	health = health - 20
	$HUD.update_health(health)
	if health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
#		$Sola2.hide()
#		$Sola2/CollisionShape2D.set_deferred("disabled",true)
#		game_over()

func _on_mob_timer_timeout():
	# Identifying mob spawn location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	# vector between sola and mob (from mob to sola for direction)
	var dir = $Sola2.position - mob_spawn_location.position
	var dir_angle = tan(dir.y/dir.x)
	
	if num_mob1 < 11: # SPAWNING MOB TYPE 1
		num_mob1 += 1
		var mob = preload("res://mob.tscn").instantiate()
		mob.position = mob_spawn_location.position
		var mob_pos = mob.position
		#direction += randf_range(-PI / 8, PI / 8)
		mob.rotation = dir_angle
		var velocity = mob_pos.direction_to($Sola2.position) * randf_range(150.0,250.0) 
		mob.linear_velocity = velocity
		add_child(mob)
		
		
	if num_mob1 > 10: # SPAWNS MOB TYPE 2
		num_mob2 += 1
		print("mob2 spawning")
		var mob2 = preload("res://mob2.tscn").instantiate()
		mob2.position = mob_spawn_location.position
		var mob2_pos = mob2.position
		mob2.rotation = dir_angle
		var velocity2 = mob2_pos.direction_to($Sola2.position) * randf_range(150.0,250.0) 
		mob2.linear_velocity = velocity2
		add_child(mob2)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	pass # Replace with function body.

func shine():
	print("Flashlight ON")
	$FlashTimer.start()
	$Sola2/FlashLight/CollisionPolygon2D.disabled = false
	$Sola2/FlashLight.show()
	

func _on_light_timer_timeout():
	
	#lamps are disabled
#	$Lamps/Lamp/LampLight.hide()
#	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp2/LampLight.hide()
#	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp3/LampLight.hide()
#	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp4/LampLight.hide()
#	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp5/LampLight.hide()
#	$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp6/LampLight.hide()
#	$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp7/LampLight.hide()
#	$Lamps/Lamp7/LampLight/CollisionPolygon2D.disabled = true
#	$Lamps/Lamp8/LampLight.hide()
#	$Lamps/Lamp8/LampLight/CollisionPolygon2D.disabled = true
	
	#Find randomm lamp to turn on
	if rand_num == 1:
		$Lamps/Lamp/LampLight.show()
		$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = false
		
	elif rand_num == 2:
		$Lamps/Lamp2/LampLight.show()
		$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = false
	elif rand_num == 3:
		$Lamps/Lamp3/LampLight.show()
		$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = false
	elif rand_num == 4:
		$Lamps/Lamp4/LampLight.show()
		$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = false
	elif rand_num == 5:
		$Lamps/Lamp5/LampLight.show()
		$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = false
	elif rand_num == 6:
		$Lamps/Lamp6/LampLight.show()
		$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = false
	elif rand_num == 7:
		$Lamps/Lamp7/LampLight.show()
		$Lamps/Lamp7/LampLight/CollisionPolygon2D.disabled = false
	elif rand_num == 8:
		$Lamps/Lamp8/LampLight.show()
		$Lamps/Lamp8/LampLight/CollisionPolygon2D.disabled = false
	rand_num = randi() % 8 + 1

func _on_flash_timer_timeout():
	print("Flahslight off")
#	$Sola2/FlashLight.hide()
#	$Sola2/FlashLight/CollisionPolygon2D.disabled = true
