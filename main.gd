extends Node2D
@export var mob_scene: PackedScene
var score
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.start()
	$BGM.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$BGM.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("spawn"):
		mob_spawn()

func mob_spawn():
	pass


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	# vector between sola and mob (from mob to sola for direction)
	var dir = $Sola2.position - mob_spawn_location.position
	
	'''
	print("Dir:")
	print(dir)
	print("direction:")
	print(direction)
	'''
	
	mob.position = mob_spawn_location.position
	var mob_pos = mob.position
	
	#direction += randf_range(-PI / 8, PI / 8)
	mob.rotation = direction

	var velocity = mob_pos.direction_to($Sola2.position) * randf_range(150.0,250.0) 
	
	mob.linear_velocity = velocity
	
	add_child(mob)

func game_over():
	$MobTimer.stop()
	$BGM.stop()
	$HUD.show_game_over()

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_score_timer_timeout():
	pass # Replace with function body.
