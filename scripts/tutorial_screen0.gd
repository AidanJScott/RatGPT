extends Sprite2D
@onready var block_clicks: Panel = $"../block_clicks"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if LevelManager._level_beenCompleted(2):
		hide()
	else:
		await get_tree().create_timer(15.0).timeout
		get_child(0).show()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	visible = false
	block_clicks.hide()
