extends Node2D
signal cheesed

func _on_area_2d_area_entered(area: Area2D) -> void:
	visible = false
	$AudioStreamPlayer2D.play()
	



func _on_audio_stream_player_2d_finished() -> void:
	cheesed.emit()
	queue_free()
