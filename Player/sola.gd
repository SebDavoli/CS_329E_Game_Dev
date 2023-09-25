extends Area2D
# $SolaAnimation.play("walk_down")

@export var speed = 200
var screen_size

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
		
		
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
