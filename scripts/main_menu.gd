extends Control

@onready var cheese: Sprite2D = $Cheese

var button_type = null

@export var max_size: Vector2 = Vector2(0.06, 0.06)
@export var min_size: Vector2 = Vector2(0.04, 0.04)
@export var duration: float = 1.5

func _ready():
	start_pulsing()

func start_pulsing():
	var tween = create_tween().set_loops()
	
	tween.tween_property(cheese, "scale", max_size, duration).set_trans(Tween.TRANS_SINE)
	tween.tween_property(cheese, "scale", min_size, duration).set_trans(Tween.TRANS_SINE)

func _on_start_pressed() -> void:
	button_type = "start"
	$fade_transition.show()
	$fade_transition/fade_timer.start() 
	$fade_transition/AnimationPlayer.play("fade_in")

func _on_options_pressed() -> void:
	button_type = "options"
	$fade_transition.show()
	$fade_transition/fade_timer.start() 
	$fade_transition/AnimationPlayer.play("fade_in")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/UI/level_select.tscn")
	elif button_type == "options":
		get_tree().change_scene_to_file("res://scenes/UI/OptionsMenu.tscn")
