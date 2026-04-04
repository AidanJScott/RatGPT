extends Control

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var total_time_seconds: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_ended.connect(_on_level_end_received)
	$Timer.start()

func _on_timer_timeout() -> void:
	total_time_seconds += 1
	var m = int (total_time_seconds / 60)
	var s = total_time_seconds - m * 60
	
	$Label.text = '%02dm:%02ds' % [m, s]

func _on_level_end_received():
	$Timer.stop()
	
	var savedScore: String = LevelManager._get_saved_score()
	savedScore = savedScore.replace("m","").replace("s", "")
	var split = savedScore.split(":")
	var intValOfTime: int = (int(split[0]) * 60) + int(split[1])

	if total_time_seconds < intValOfTime:
		print("Saving")
		LevelManager._save_level_score($Label.text)
