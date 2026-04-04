extends Resource
class_name SaveGame

const SAVE_GAME_PATH:= "user://savegame.tres"

@export var level0_highScore: String = "00m:00s"
@export var level1_highScore: String = "00m:00s"
@export var level2_highScore: String = "00m:00s"

@export var levels_beenCompleted: Array[bool] = [
	false,
	false,
	false
]

func write_savegame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)
	
static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
