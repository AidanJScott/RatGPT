extends Control




func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	$ColorRect/fade_transition
	$ColorRect/fade_transition/fade_timer.start() 
	$ColorRect/fade_transition/AnimationPlayer.play("fade_in")

func _on_fade_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://matt/scenes/LevelTemplate.tscn")
