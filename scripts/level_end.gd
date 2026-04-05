extends Control

func _on_button_pressed() -> void:
	EventBus.level_ended.emit()
	trigger_next_level()
	
func trigger_next_level():
	LevelManager._level_complete_next()
	
	#get_tree().paused = true
	#dimmer.visible = true
	#dimmer.modulate.a = 0.0

	#var tween = create_tween()
	#tween.tween_property(dimmer, "modulate:a", 0.6, 0.5)

	#await tween.finished
	#get_tree().paused = true
