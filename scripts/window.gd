extends Node2D
@onready var pause_menu: Control = $pause_menu
var paused = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu_handler()
		
func pause_menu_handler():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
