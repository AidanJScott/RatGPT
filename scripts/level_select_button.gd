extends Button

@onready var timer_label: Label = $TimerLabel
@onready var check_box: CheckBox = $CheckBox
@onready var level_select_button: Button = $"."

var level_to_load: int = 1
var is_unlocked: bool = false

func _ready() -> void:
	#print("Level To Load: ", level_to_load)
	#print("Loadable: ", LevelManager.level_unlocked)
	level_to_load = get_index()
	text = str(level_to_load)
	is_unlocked = level_to_load <= LevelManager.level_unlocked
	if is_unlocked:
		if LevelManager._level_beenCompleted(level_to_load):
			print(LevelManager._level_beenCompleted(level_to_load))
			check_box.set_pressed_no_signal(true)
			level_select_button.modulate = Color(1, 0.84, 0.0)
	else:
		modulate.a = 0.5
	
	check_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$TimerLabel.text = LevelManager._get_saved_score(level_to_load)

func _enter_tree():
	request_ready()

func _pressed() -> void:
	if is_unlocked:
		LevelManager._load_level(level_to_load)
