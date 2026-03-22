extends Node

var current_level: int = 0
var level_unlocked: int = 1
var max_level: int = 1

func _unlock_level(level_to_unlock: int) -> void:
	if level_to_unlock > level_unlocked:
		level_unlocked = level_to_unlock
		
func _load_level(level_to_load: int) -> void:
	current_level = level_to_load
	if level_to_load > max_level:
		return #credits/thanks for playing should go here
	get_tree().call_deferred("change_scene_to_file", str("res://levels/", level_to_load, ".tscn"))


func _level_complete_next():
	_unlock_level(current_level + 1)
	_load_level(current_level + 1)
