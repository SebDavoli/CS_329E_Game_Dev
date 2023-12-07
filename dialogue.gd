extends CanvasLayer

@onready var container = $DialogueContainer
@onready var label = $DialogueContainer/MarginContainer/HBoxContainer/VBoxContainer/Label 
var CHAR_RATE = 0.02
var MAX_SHOW = 5.00
var executing = -1
var dialogue_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_dialogue()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $ProcessingTimer.is_stopped() and len(dialogue_array) > 0 and (Input.is_action_pressed("next_dialogue") or executing == -1):
		$ProcessingTimer.start()
		print("DIALOGUE moving to %s" % (executing + 1))
		if executing + 1 < len(dialogue_array):
			executing += 1
			
			set_text(dialogue_array[executing])
		else:
			executing = -1
			dialogue_array = []
			hide_dialogue()
			$Sound.stop()
	
func hide_dialogue():
	label.text = ""
	container.hide()
	
func load_dialogue(dialogue_sequence):
	dialogue_array = dialogue_sequence
	
func set_text(text):
	var current_execution_step = executing
	label.visible_characters = 0
	label.text = text
	container.show()
	while label.visible_characters <= len(text) or current_execution_step != executing:
		$Sound.play()
		label.visible_characters += 1
		await get_tree().create_timer(CHAR_RATE).timeout
