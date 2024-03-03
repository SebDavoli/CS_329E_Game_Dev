extends CharacterBody2D
signal damage
signal light
signal heal

@export var speed = 200
var viewport_size
var camera: Camera2D
var beam_speed = 1000
var beam = preload("res://light_beam.tscn")
var drift = preload("res://light_drift.tscn")
var movement_disabled = false

# Movement limits (add as many as you want Team 10):
var y_max = 400

@onready var head = $Marker2D

func _ready():
	$FlashLight.show()
	$AnimatedSprite2D.play("idle")
	$FlashLight/AnimationPlayer.play("flicker")
	viewport_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $FlashLight/CollisionPolygon2D.disabled == false:
		$FlashLight/AnimationPlayer.play("flicker")	
	var new_viewport_size = get_viewport_rect().size
#	camera.zoom *= new_viewport_size / viewport_size
	viewport_size = new_viewport_size
	
	if movement_disabled:
		return
		
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1.5
		$Marker2D.position = Vector2(125, 10)	
		$FlashLight.rotation_degrees = 135	
		
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1.5
		$Marker2D.position = Vector2(-125, -15)
		$FlashLight.rotation_degrees = 315	
		
					
	if Input.is_action_pressed("move_down"):
		velocity.y += 1.5
		$AnimatedSprite2D.play("walk_down")
		$Marker2D.position = Vector2(0,125)	
		$FlashLight.rotation_degrees = 225			
		
		
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1.5
		$AnimatedSprite2D.play("walk_up")
		$Marker2D.position = Vector2(0,-125)
		$FlashLight.rotation_degrees = 45	
	
	if velocity.x != 0:	
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	
#	if velocity.x == 0 and velocity.y == 0:
#		$AnimatedSprite2D.animation = "idle"
		
	if velocity.length() > 0:
#		print(velocity)
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# Implementing and Limiting player movement
	move_and_collide(velocity * delta)
	$FlashLight.position = $Marker2D.position
	
func _on_body_entered(body):
	print("Sola: ")
	print(body.get_name())
	if body.get_name() == "Flashlight":
		light.emit()
	if body.is_in_group("sundaes"):
		heal.emit()
	if body.get_name() == "LampLight":
		light.emit()
	if body.is_in_group("mobs"):
		damage.emit()
		$PainEffect.play()
		$AnimatedSprite2D.modulate = Color8(255,0,0,255)
		$PainTimer.start()
	if body.get_name() == "Level_1":
		get_tree().call_group("mobs", "queue_free")
		get_tree().change_scene_to_file("res://main.tscn")
	if body.get_name() == "Next_Level":
		get_tree().call_group("mobs", "queue_free")
		get_tree().change_scene_to_file("res://level_2.tscn")
	if body.get_name() == "Level_3":
		get_tree().call_group("mobs", "queue_free")
		get_tree().change_scene_to_file("res://level_3.tscn")
	if body.get_name() == "Ending":
		get_tree().call_group("mobs", "queue_free")
		get_tree().change_scene_to_file("res://win.tscn")

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func Light_Drift():
	var drift_instance = drift.instantiate()
	
	get_parent().add_child(drift_instance)
	drift_instance.global_position = $Marker2D.global_position
	drift_instance.velocity = $Marker2D.position
	if$Marker2D.position == Vector2(50, 0):
		drift_instance.rotation = 0;
	elif$Marker2D.position == Vector2(-50, 0):
		drift_instance.rotation = -110;
	elif$Marker2D.position == Vector2(0, 50):
		drift_instance.rotation = -80;
	elif$Marker2D.position == Vector2(0, -50):
		drift_instance.rotation = 80;

func _on_pain_timer_timeout():
	$AnimatedSprite2D.modulate = Color8(255,255,255,255)

func flash_on():
	$FlashLight/AnimationPlayer.stop()
	$FlashLight/AnimationPlayer.play("flicker")
