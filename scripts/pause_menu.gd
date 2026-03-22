extends Control

@onready var main = $"../"

func _on_contiune_pressed() -> void:
	main.pause_menu_handler()

func _on_quit_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")

func _on_options_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/UI/OptionsMenu.tscn")
