extends Area2D

@export var speed = 200
var screen_size
var beam = preload("res://light_beam.tscn")

@onready var head = $Marker2D

func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.play("walk_right")	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.play("walk_left")
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("walk_down")
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1	
		$AnimatedSprite2D.play("walk_up")
	if Input.is_action_just_released("attack"):
		speed_shine()
		
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func speed_shine():
	var beam_instance = beam.instantiate()
	beam_instance.look_at(get_global_mouse_position())
	get_parent().add_child(beam_instance)
	beam_instance.global_position = $Marker2D.global_position
#	beam_instance.velocity = get_global_mouse_position() - beam_instance.position
