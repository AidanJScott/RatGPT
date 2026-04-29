extends Control
@onready var text: RichTextLabel = $vbox_text/text
@onready var continue_button: Button = $continue_button
@onready var rat_image_arrows: Sprite2D = $"../background/rat_image_arrows"
@onready var story_0: Node2D = $".."
@onready var cheese: Sprite2D = $"../background/cheese"

var dialogue = 		["Hello there I am Dr. Cheese... \nand I assume you're my new lab assistant...", 
					"I need you to help get these other rats through a few mazes to get a wonderful piece of CHEESE...",
					"So far I have only gotten them to move in four directions, which is really all you need...",
					"But theres a catch...",
					"You have to tell the rats EVERY move that they will make...",
					"Good Luck!"]
var current_line = 0

func _ready() -> void:
	display_line(dialogue[0])

func display_line(line: String):
	text.text = line
	continue_button.grab_focus()
	
	if current_line == 1:
		cheese.show()
	if current_line == 2:
		rat_image_arrows.show()
	
	

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
