extends Node2D
var health
var num_mob1 = 0
var num_mob2 = 0
var rand_num1
var rand_num2
var rand_num3

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_level = 2
	Global.kill_count = 0
	Global.goal = 40
	$HUD/GoalKill.text = str(Global.goal)
	health = 100
	$LightTimer.start()
	$Sola.start($StartPosition.position)
	$StartTimer.start()
	$FlashTimer.start()
	
	$BGM.play()
	$Level_3.show()
	$Sola.camera = $Sola/Camera2D
	$HUD.update_health(health)
	
	rand_num1 = randi() % 6 + 1
	rand_num2 = randi() % 6 + 1
	rand_num3 = randi() % 6 + 1
	
	$Lamps/Lamp/LampLight.hide()
	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp2/LampLight.hide()
	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp3/LampLight.hide()
	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp4/LampLight.hide()
	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp5/LampLight.hide()
	$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp6/LampLight.hide()
	$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = true
	
	$DialogueBox.load_dialogue(["I think defeating the monsters open the path...! Maybe this leads me to Luna?"])
	
func _process(delta):
#	print($Sola/FlashLight/CollisionPolygon2D.disabled)
#	print($FlashTimer.get_time_left())
	$HUD.update_charge($FlashTimer.get_time_left())
	if $FlashTimer.get_time_left() > 0:
		$Sola/FlashLight/CollisionPolygon2D.disabled = false
	
	$HUD/CurrentKill.text = str(Global.kill_count)
	print(Global.kill_count)

	if Global.kill_count >= Global.goal:
		$MobTimer.stop()
		$HUD/Arrow.show()
		$Fence.hide()
		$Fence/CollisionShape2D.disabled = true
		$Fence2.hide()
		$Fence2/CollisionShape2D.disabled = true
		$Fence3.hide()
		$Fence3/CollisionShape2D.disabled = true
		$Fence4.hide()
		$Fence4/CollisionShape2D.disabled = true
		$Fence5.hide()
		$Fence5/CollisionShape2D.disabled = true

func heal():
	if health <= 80:
		health = health + 20
	$HUD.update_health(health)
	
func change_health():
	health = health - 20
	$HUD.update_health(health)
	if health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
#		$Sola.hide()
#		$Sola/CollisionShape2D.set_deferred("disabled",true)

func _on_mob_timer_timeout():
	# Identifying mob spawn location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	# vector between sola and mob (from mob to sola for direction)
	var dir = $Sola.position - mob_spawn_location.position
	var dir_angle = tan(dir.y/dir.x)

	#Spawn Mob 1
	num_mob1 += 1
	var mob = preload("res://mob.tscn").instantiate()
	mob.position = mob_spawn_location.position
	var mob_pos = mob.position
	#direction += randf_range(-PI / 8, PI / 8)
	mob.rotation = dir_angle
	var velocity = mob_pos.direction_to($Sola.position) * randf_range(150.0,250.0) 
	mob.linear_velocity = velocity
	add_child(mob)
		
	if num_mob1 > 10: # SPAWNS MOB TYPE 2
		num_mob2 += 1
		print("mob2 spawning")
		var mob2 = preload("res://mob2.tscn").instantiate()
		mob2.position = mob_spawn_location.position
		var mob2_pos = mob2.position
		mob2.rotation = dir_angle
		var velocity2 = mob2_pos.direction_to($Sola.position) * randf_range(150.0,250.0) 
		mob2.linear_velocity = velocity2
		add_child(mob2)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	pass # Replace with function body.

func _on_light_timer_timeout():
	$Lamps/Lamp/LampLight.hide()
	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp2/LampLight.hide()
	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp3/LampLight.hide()
	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp4/LampLight.hide()
	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp5/LampLight.hide()
	$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp6/LampLight.hide()
	$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = true
	
	if rand_num1 == 1 or rand_num2 == 1 or rand_num3 == 1:
		$Lamps/Lamp/LampLight.show()
		$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 2 or rand_num2 == 2 or rand_num3 == 2:
		$Lamps/Lamp2/LampLight.show()
		$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 3 or rand_num2 == 3 or rand_num3 == 3:
		$Lamps/Lamp3/LampLight.show()
		$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 4 or rand_num2 == 4 or rand_num3 == 4:
		$Lamps/Lamp4/LampLight.show()
		$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 5 or rand_num2 == 5 or rand_num3 == 5:
		$Lamps/Lamp5/LampLight.show()
		$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 6 or rand_num2 == 6 or rand_num3 == 6:
		$Lamps/Lamp6/LampLight.show()
		$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = false
		
	rand_num1 = randi() % 6 + 1
	rand_num2 = randi() % 6 + 1
	rand_num3 = randi() % 6 + 1

func _on_flash_timer_timeout():
	print("Flahslight off")
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true

func shine():
	$Sola/FlashLight.show()
	print("Flashlight ON")
	$FlashTimer.start()	
