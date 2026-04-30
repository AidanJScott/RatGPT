extends Control
@onready var text: RichTextLabel = $vbox_text/text
@onready var continue_button: Button = $continue_button
@onready var rat_image_arrows: Sprite2D = $"../background/rat_image_arrows"
@onready var story_0: Node2D = $".."
@onready var chart_2: Sprite2D = $"../background/chart2"
@onready var weights_2: Sprite2D = $"../background/weights2"

var dialogue = 		["See? Not too hard...", 
					"Here's that bigger maze again...\nThis one may be a bit difficult...",
					"I gave you two more options to work with...\nSo have fun!"]
var current_line = 0

func _ready() -> void:
	display_line(dialogue[0])

func display_line(line: String):
	text.text = line
	continue_button.grab_focus()
	if current_line == 2:
		chart_2.show()
		weights_2.show()
	

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
