extends Node2D
@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobTimer.start()
	print("penis!")



func new_game():
	score = 0
	#$sola.start(250,250)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = (250.0,250.0) #get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI/2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI/4,PI/4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
