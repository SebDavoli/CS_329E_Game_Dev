extends Area2D
signal hit
signal damage

@export var speed = 200
var screen_size
var beam_speed = 1000
var beam = preload("res://light_beam.tscn")

# Movement limits (add as many as you want Team 10):
var y_max = 400

@onready var head = $Marker2D

func _ready():
	$AnimatedSprite2D.play("idle")
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$Marker2D.position = Vector2(50, 0)	
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$Marker2D.position = Vector2(-50, 0)
					
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("walk_down")
		$Marker2D.position = Vector2(0,50)	
		
		
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1	
		$AnimatedSprite2D.play("walk_up")
		$Marker2D.position = Vector2(0,-50)	
	
	if velocity.x != 0:	
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	
	if Input.is_action_pressed("attack"):
		$ChargeTimer.start()
	
	if Input.is_action_just_released("attack"):
		speed_shine()
		$ShootEffect.play()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# Implementing and Limiting player movement
	position += velocity * delta
	
	if position.y < y_max:
		position = Vector2(position.x,y_max)
	
	# Limiting movement to within the screen
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
func _on_body_entered(body):
	if body.is_in_group("mobs"):
		damage.emit()
#		

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func speed_shine():
	var beam_instance = beam.instantiate()
#	beam_instance.look_at(get_global_mouse_position())
	get_parent().add_child(beam_instance)
	beam_instance.global_position = $Marker2D.global_position
	beam_instance.velocity = $Marker2D.position
	if$Marker2D.position == Vector2(50, 0):
		beam_instance.rotation = 0;
	elif$Marker2D.position == Vector2(-50, 0):
		beam_instance.rotation = -110;
	elif$Marker2D.position == Vector2(0, 50):
		beam_instance.rotation = -80;
	elif$Marker2D.position == Vector2(0, -50):
		beam_instance.rotation = 80;

func charged_shine():
	var beam_instance = beam.instantiate()
#	beam_instance.look_at(get_global_mouse_position())
	get_parent().add_child(beam_instance)
	beam_instance.global_position = $Marker2D.global_position
	beam_instance.velocity = $Marker2D.position
#	beam_instance.scale = (1.5,1.5)
	if$Marker2D.position == Vector2(50, 0):
		beam_instance.rotation = 0;
	elif$Marker2D.position == Vector2(-50, 0):
		beam_instance.rotation = -110;
	elif$Marker2D.position == Vector2(0, 50):
		beam_instance.rotation = -80;
	elif$Marker2D.position == Vector2(0, -50):
		beam_instance.rotation = 80;

func _on_charge_timer_timeout():
	charged_shine()
