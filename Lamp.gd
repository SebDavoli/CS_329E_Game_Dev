extends RigidBody2D

signal Light_Drift_Ready

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_lamp_light_area_entered(area): 
	# if area is player:
	#	Light_Drift_Ready.emit()
