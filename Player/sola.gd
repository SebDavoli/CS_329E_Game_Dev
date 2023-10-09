class_name Sola
extends CharacterBody2D

@export var speed = 200
var viewport_size
var target_aspect_ratio
var is_captured
var camera: Camera2D
var beam_speed = 1000
var beam = preload("res://light_beam.tscn")

signal captured

@onready var head = $Marker2D

func _ready():
	$AnimatedSprite2D.play("idle")
	viewport_size = get_viewport_rect().size
	target_aspect_ratio = viewport_size.aspect()
	is_captured = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_captured:
		return
	var new_viewport_size = get_viewport_rect().size
	camera.zoom *= new_viewport_size / viewport_size
	viewport_size = new_viewport_size
		
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
		
	if Input.is_action_just_released("attack"):
		speed_shine()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

		
	#var new_position = position + 
	#position = new_position
	move_and_collide((velocity * delta))


func speed_shine():
	if is_captured:
		return
	var beam_instance = beam.instantiate()
#	beam_instance.look_at(get_global_mouse_position())
	get_parent().add_child(beam_instance)
	beam_instance.global_position = $Marker2D.global_position
	beam_instance.velocity = $Marker2D.position


func _on_area_2d_body_entered(body):
	if body is Mob:
		hide()
		is_captured = true
		captured.emit()
