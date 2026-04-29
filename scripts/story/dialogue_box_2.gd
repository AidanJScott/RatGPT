extends Control
@onready var text: RichTextLabel = $vbox_text/text
@onready var continue_button: Button = $continue_button
@onready var rat_image_arrows: Sprite2D = $"../background/rat_image_arrows"
@onready var story_0: Node2D = $".."
@onready var chart: Sprite2D = $"../background/chart"
@onready var weights: Sprite2D = $"../background/weights"

var dialogue = 		["Wonderful job! Let's try something different I've been working on...", 
					"I'd like you to try something a bit more difficult...",
					"This is what I call a probablistic model. Each direction is given a percentage value, what we call a weight, to determine how likely it is for a rat to move in that direction...",
					"You are able to do less work by setting these weights as you go INSTEAD of instructing every move,\nIn this case the RUN button moves the rat 10 spaces at a time...",
					"Also, notice how the chart will change as you move the sliders. This is representing a network of possibilities...\nA neural network perhaps...",
					"Anyway, get to work!"]
var current_line = 0

func _ready() -> void:
	display_line(dialogue[0])

func display_line(line: String):
	text.text = line
	continue_button.grab_focus()
	
	if current_line == 2:
		chart.show()
		weights.show()
	
	

func _on_continue_button_pressed() -> void:
	get_next_line()
	display_line(dialogue[current_line])

func get_next_line():
	if current_line < dialogue.size() - 1:
		current_line += 1
	else:
		story_0.hide()

func open():
	visible = true

func close():
	visible = false
