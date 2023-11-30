extends Node2D
var health
var num_mob1 = 0
var num_mob2 = 0
var num_mob3 = 0
var num_mob4 = 0
var rand_num1

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.kill_count = 0
	Global.goal = 60
	$HUD/GoalKill.text = str(Global.goal)
	health = 100
	$LightTimer.start()
	$Sola.start($StartPosition.position)
	$StartTimer.start()
	$FlashTimer.start()
	
	$BGM.play()
	$Ending.show()
	$Sola.camera = $Sola/Camera2D
	$HUD.update_health(health)

	rand_num1 = randi() % 6 + 1
	
	$Lamps/Lamp/LampLight.hide()
	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp2/LampLight.hide()
	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp3/LampLight.hide()
	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp4/LampLight.hide()
	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD.update_charge($FlashTimer.get_time_left())
	if $FlashTimer.get_time_left() > 0:
		$Sola/FlashLight/CollisionPolygon2D.disabled = false
		
	$HUD/CurrentKill.text = str(Global.kill_count)
	#print(Global.kill_count)
	
	if Global.kill_count == Global.goal:
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

func change_health():
	health = health - 20
	$HUD.update_health(health)
	if health <= 0:
		get_tree().change_scene_to_file("res://gameover.tscn")

func _on_mob_timer_timeout():
# Identifying mob spawn location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	# vector between sola and mob (from mob to sola for direction)
	var dir = $Sola.position - mob_spawn_location.position
	var dir_angle = tan(dir.y/dir.x)
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
	if num_mob1 > 10: 
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
	if num_mob2 >= 10 && num_mob2%2 == 0: 
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
	$Lamps/Lamp/LampLight.hide()
	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp2/LampLight.hide()
	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp3/LampLight.hide()
	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp4/LampLight.hide()
	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true
	
	if rand_num1 == 1:
		$Lamps/Lamp/LampLight.show()
		$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 2:
		$Lamps/Lamp2/LampLight.show()
		$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 3:
		$Lamps/Lamp3/LampLight.show()
		$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = false
	if rand_num1 == 4:
		$Lamps/Lamp4/LampLight.show()
		$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = false
		
	rand_num1 = randi() % 4 + 1


func _on_flash_timer_timeout():
	print("Flahslight off")
	$Sola/FlashLight.hide()
	$Sola/FlashLight/CollisionPolygon2D.disabled = true

func shine():
	$Sola/FlashLight.show()
	print("Flashlight ON")
	$FlashTimer.start()	

