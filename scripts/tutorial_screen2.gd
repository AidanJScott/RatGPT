extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if LevelManager._level_beenCompleted(0):
		hide()
	else:
		await get_tree().create_timer(5.0).timeout
		get_child(0).show()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	visible = false
