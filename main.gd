extends Node2D
@export var mob_scene: PackedScene
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sola2.camera = $Sola2/Camera2D
	pass
	
func _process(delta):
	pass
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$BGM.stop()
	$HUD.show_game_over()
	
func new_game():
	health = 100
	$Sola2.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_health(health)
	$HUD.show_message("Where am I?")
	$BGM.play()
	await $HUD/MessageTimer.timeout
	$HUD/Controls.show()
#	get_tree().call_group("mobs", "queue_free")

func change_health():
	health = health - 20
	$HUD.update_health(health)
	if health <= 0:
		$Sola2.hide()
		$Sola2/CollisionShape2D.set_deferred("disabled",true)
		game_over()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	# vector between sola and mob (from mob to sola for direction)
	var dir = $Sola2.position - mob_spawn_location.position
	
	mob.position = mob_spawn_location.position
	var mob_pos = mob.position
	
	#direction += randf_range(-PI / 8, PI / 8)
	mob.rotation = direction

	var velocity = mob_pos.direction_to($Sola2.position) * randf_range(150.0,250.0) 
	
	mob.linear_velocity = velocity
	
	add_child(mob)

func _on_start_timer_timeout():
	$HUD/Controls.hide()
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	pass # Replace with function body.
