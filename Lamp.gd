extends StaticBody2D

signal Light_Drift_Ready

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if $LampLight/CollisionPolygon2D.disabled == false:
		$LampLight/AnimationPlayer.play("flicker")

func _on_lamp_light_area_entered(area): 
	if area.is_in_group("player"):
		#print("light entered")
		Light_Drift_Ready.emit()
