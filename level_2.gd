extends Node2D
@export var mob_scene: PackedScene
var health
var num_mob1 = 0
var rand_num

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sola2.camera = $Sola2/Camera2D
	
	rand_num = randi() % 8 + 1
	$Lamps/Lamp/LampLight.hide()
	$Lamps/Lamp/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp2/LampLight.hide()
	$Lamps/Lamp2/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp3/LampLight.hide()
	$Lamps/Lamp3/LampLight/CollisionPolygon2D.disabled = true
	$Lamps/Lamp4/LampLight.hide()
	$Lamps/Lamp4/LampLight/CollisionPolygon2D.disabled = true
	
	health = 100
	$LightTimer.start()
	$Sola2.start($StartPosition.position)
	$StartTimer.start()
	$FlashTimer.start()
	$HUD.update_health(health)
	$BGM.play()
	$HUD/Message.hide()
	$HUD/StartButton.hide()
	
func _process(delta):
	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$BGM.stop()
	$HUD.show_game_over()
	
func change_health():
	
	health = health - 20
	$HUD.update_health(health)
	if health <= 0:
		$Sola2.hide()
		$Sola2/CollisionShape2D.set_deferred("disabled",true)
		game_over()

func _on_mob_timer_timeout():
	num_mob1 += 1
	if num_mob1 < 11:
		var mob = mob_scene.instantiate()
	
		var mob_spawn_location = $MobPath/MobSpawnLocation
		mob_spawn_location.progress_ratio = randf()
	
		var direction = mob_spawn_location.rotation + PI / 2
	
		# vector between sola and mob (from mob to sola for direction)
		var dir = $Sola2.position - mob_spawn_location.position
		var dir_angle = tan(dir.y/dir.x)
	
		mob.position = mob_spawn_location.position
		var mob_pos = mob.position
	
		#direction += randf_range(-PI / 8, PI / 8)
		mob.rotation = dir_angle

		var velocity = mob_pos.direction_to($Sola2.position) * randf_range(150.0,250.0) 
	
		mob.linear_velocity = velocity
	
		add_child(mob)

func _on_start_timer_timeout():
	$HUD/Controls.hide()
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
	rand_num = randi() % 4 + 1
