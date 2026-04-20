extends Node

var current_level: int = 1
var level_unlocked: int = 1
var max_level: int = 4

var current_save: SaveGame

func _ready():
	var loaded_data: Resource = SaveGame.load_savegame()
	if loaded_data != null:
		current_save = loaded_data as SaveGame
	else:
		current_save = SaveGame.new() 

func _unlock_level(level_to_unlock: int) -> void:
	if level_to_unlock > level_unlocked:
		level_unlocked = level_to_unlock
		
func _load_level(level_to_load: int) -> void:
	current_level = level_to_load
	MoveCounter.reset_steps()
	if level_to_load > max_level:
		return #credits/thanks for playing should go here
	get_tree().call_deferred("change_scene_to_file", str("res://levels/", level_to_load, ".tscn"))


func _level_complete_next():
	current_save.levels_beenCompleted[current_level] = true
	current_save.write_savegame()
	
	_unlock_level(current_level + 1)
	_load_level(current_level + 1)
	
func _level_beenCompleted(level: int = current_level) -> bool:
	return current_save.levels_beenCompleted[level]
	
func _get_saved_score(level: int = current_level) -> String:
	if current_save == null:
		return "00m:00s"
	
	var variable_name: String = "level%d_highScore" % level
	var retrived_score = current_save.get(variable_name)
	
	if retrived_score != null:
		return retrived_score
	else:
		print("Warning: '", variable_name, "' does not exist in save data.")
		return "00m:00s"
		
func _save_level_score(new_score: String, level: int = current_level):
	if current_save == null:
		printerr("Cannot save, no save file loaded.")
		return
	
	var variable_name: String = "level%d_highScore" % level
	
	current_save.set(variable_name, new_score)
	current_save.write_savegame()
	
func _reset_save_progress():
	current_save.reset_save_progress()

func _set_colorblind(new_index: int):
	current_save.set("colourblind_mode", new_index)
	current_save.write_savegame()

func _get_colorblind() -> int:
	return current_save.get("colourblind_mode")
