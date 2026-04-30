extends Control
@onready var text: RichTextLabel = $vbox_text/text
@onready var continue_button: Button = $continue_button
@onready var story_0: Node2D = $".."

var dialogue = 		["Wow you made it through all of my mazes today...", 
					"That last one was hard I know...\nbut you did amazing",
					"Although some automation may not be the best for some problems, it required less overall instruction for the rats...",
					"The whole idea of this automation thing is to require less upfront work on your end...\nyour instructions beceome less specific with a similar result...",
					"I'm working on an even more automated design with this new AI thing...\nI'll let you know when that's finished and get my best assistant back!",
					"I'll see you again soon!"]
var current_line = 0

func _ready() -> void:
	display_line(dialogue[0])

func display_line(line: String):
	text.text = line
	continue_button.grab_focus()
	
	

func _on_continue_button_pressed() -> void:
	get_next_line()
	display_line(dialogue[current_line])

func get_next_line():
	if current_line < dialogue.size() - 1:
		current_line += 1
	else:
		get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")

func open():
	visible = true

func close():
	visible = false
