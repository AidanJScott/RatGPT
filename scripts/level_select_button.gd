extends Button


var level_to_load: int = 1
var is_unlocked: bool = false

func _ready() -> void:
	print("Level To Load: ", level_to_load)
	print("Loadable: ", LevelManager.level_unlocked)
	level_to_load = get_index()
	text = str(level_to_load)
	is_unlocked = level_to_load <= LevelManager.level_unlocked
	modulate.a = 1.0 if is_unlocked else 0.5

func _pressed() -> void:
	if is_unlocked:
		LevelManager._load_level(level_to_load)
