extends Node2D
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
var paused = false

		
func pause_menu_handler():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused

func _on_pause_pressed() -> void:
	pause_menu_handler()
