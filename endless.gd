extends Node2D
var health
var num_mob1 = 0
var num_mob2 = 0
var num_mob3 = 0
var rand_num1
var rand_num2
var rand_num3
var rand_num4
var dialogue_loaded = false
var bgm2_executed = false
var bgm3_executed = false
var previous_kill_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_level = 1
	Global.kill_count = 0
#	Global.goal = 20
#	$HUD/GoalKill.text = str(Global.goal)
	health = 100
	$HUD/Label.hide()
	$HUD/GoalKill.hide()
	$Sola.start($StartPosition.position)
	$StartTimer.start()
	$LightTimer.start()
	$FlashTimer.start()
	$DialogueBox.load_dialogue(["Nowhere to run...might as well fight till my death..!"])
	$BGM.play()
	$Sola.camera = $Sola/Camera2D
	$HUD.update_health(health)
	
	#random number set, lamp disabled at start of the game
	rand_num1 = randi() % 8 + 1
	rand_num2 = randi() % 8 + 1
	rand_num3 = randi() % 8 + 1
	rand_num4 = randi() % 8 + 1
	
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
	$Lamps/Lamp7/LampLight.hide()
	$Lamps/Lamp7/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp8/LampLight.hide()
	$Lamps/Lamp8/LampLight/CollisionPolygon2D.disabled = true
	
	
	
func _process(delta):
	print($MobTimer.wait_time)
#	print($Sola/FlashLight/CollisionPolygon2D.disabled)
#	print($FlashTimer.get_time_left())
	$HUD.update_charge($FlashTimer.get_time_left())
	if $FlashTimer.get_time_left() > 0:
		$Sola/FlashLight/CollisionPolygon2D.disabled = false
	
	$HUD/CurrentKill.text = str(Global.kill_count)
	#print(Global.kill_count)
	
#	print($FlashTimer.get_time_left())
	
	# Check if kill_count is a multiple of 10 and if the function has not been executed yet
	if Global.kill_count % 10 == 0 and Global.kill_count != previous_kill_count:
		# Call your function here
		increase_speed()
		previous_kill_count = Global.kill_count
	
	if Global.kill_count % 50 == 49 and not bgm2_executed:
		$BGM.stop()
		$BGM2.play()
		bgm2_executed = true
	
	if Global.kill_count % 100 == 99 and not bgm3_executed:
		$BGM2.stop()
		$BGM3.play()
		bgm3_executed = true
	
#	if Global.kill_count >= Global.goal:
#		get_tree().call_group("mobs", "queue_free")
#		$Sola/Camera2D/CanvasLayer/TextureRect.hide()
#		$MobTimer.stop()
#		$HUD/Arrow.show()
#		$Fences/Fence.hide()
#		$Fences/Fence/CollisionShape2D.disabled = true
#		$Fences/Fence2.hide()
#		$Fences/Fence2/CollisionShape2D.disabled = true
#		$Fences/Fence3.hide()
#		$Fences/Fence3/CollisionShape2D.disabled = true
#		$Fences/Fence4.hide()
#		$Fences/Fence4/CollisionShape2D.disabled = true
#		$Fences/Fence5.hide()
#		$Fences/Fence5/CollisionShape2D.disabled = true
#		$Fences/Fence6.hide()
#		$Fences/Fence6/CollisionShape2D.disabled = true
#		$Fences/Fence7.hide()
	
func new_game():
	pass
#	get_tree().call_group("mobs", "queue_free")

func heal():
	if health <= 80:
		health = health + 20
	$HUD.update_health(health)

func change_health():
	health = health - 20
	$HUD.update_health(health)
	if health <= 0:
		$Sola.queue_free()
		get_tree().change_scene_to_file("res://endless_gameover.tscn")
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
	
	#Spawn Mob1
	num_mob1 += 1
	var mob = preload("res://mob.tscn").instantiate()
	mob.position = mob_spawn_location.position
	var mob_pos = mob.position
	#direction += randf_range(-PI / 8, PI / 8)
	mob.rotation = dir_angle
	var velocity = mob_pos.direction_to($Sola.position) * randf_range(150.0,250.0) 
	mob.linear_velocity = velocity
	add_child(mob)
	
	# SPAWNS MOB TYPE 2
	if Global.kill_count >= 50: 
		num_mob2 += 1
		print("mob2 spawning")
		var mob2 = preload("res://mob2.tscn").instantiate()
		mob2.position = mob_spawn_location.position
		var mob2_pos = mob2.position
		mob2.rotation = dir_angle
		var velocity2 = mob2_pos.direction_to($Sola.position) * randf_range(150.0,250.0) 
		mob2.linear_velocity = velocity2
		add_child(mob2)
	
	# SPAWNS MOB TYPE 3
	if Global.kill_count >= 100: 
		num_mob3 += 1
		print("mob3 spawning")
		var mob3 = preload("res://mob3.tscn").instantiate()
		mob3.position = mob_spawn_location.position
		var mob3_pos = mob3.position
		mob3.rotation = PI/2
		var velocity3 = mob3_pos.direction_to($Sola.position) * randf_range(150.0,250.0) 
		mob3.linear_velocity = velocity3
		add_child(mob3)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	pass # Replace with function body.

func _on_light_timer_timeout():
	#lamps are disabled
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
	$Lamps/Lamp7/LampLight.hide()
	$Lamps/Lamp7/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp8/LampLight.hide()
	$Lamps/Lamp8/LampLight/CollisionPolygon2D.disabled = true
	
	#Find random lamp to turn on
	if rand_num1 == 1 or rand_num2 == 1 or rand_num3 == 1 or rand_num4 == 1:
		$Lamps/Lamp/LampLight.show()
		$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 2 or rand_num2 == 2 or rand_num3 == 2 or rand_num4 == 2:
		$Lamps/Lamp2/LampLight.show()
		$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 3 or rand_num2 == 3 or rand_num3 == 3 or rand_num4 == 3:
		$Lamps/Lamp3/LampLight.show()
		$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 4 or rand_num2 == 4 or rand_num3 == 4 or rand_num4 == 4:
		$Lamps/Lamp4/LampLight.show()
		$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 5 or rand_num2 == 5 or rand_num3 == 5 or rand_num4 == 5:
		$Lamps/Lamp5/LampLight.show()
		$Lamps/Lamp5/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 6 or rand_num2 == 6 or rand_num3 == 6 or rand_num4 == 6:
		$Lamps/Lamp6/LampLight.show()
		$Lamps/Lamp6/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 7 or rand_num2 == 7 or rand_num3 == 7 or rand_num4 == 7:
		$Lamps/Lamp7/LampLight.show()
		$Lamps/Lamp7/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 8 or rand_num2 == 8 or rand_num3 == 8 or rand_num4 == 8:
		$Lamps/Lamp8/LampLight.show()
		$Lamps/Lamp8/LampLight/CollisionPolygon2D.disabled = false
		
	rand_num1 = randi() % 8 + 1
	rand_num2 = randi() % 8 + 1
	rand_num3 = randi() % 8 + 1
	rand_num4 = randi() % 8 + 1
	if Global.kill_count >= 150:
		rand_num2 = 0
	if Global.kill_count >= 100:
		rand_num3 = 0
	if Global.kill_count >= 50:
		rand_num4 = 0

func _on_flash_timer_timeout():
	#print("Flahslight off")
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true

func shine():
	$Sola/FlashLight.show()
	$Sola/FlashLight/CollisionPolygon2D.disabled = false
	$FlashTimer.start()
	$FlashTimer.paused = true

func flicker():
	$FlashTimer.paused = false

func increase_speed():
	$MobTimer.wait_time -= 0.1
