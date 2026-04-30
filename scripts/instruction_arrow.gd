extends Polygon2D
var original_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	show()
	await get_tree().create_timer(0.5).timeout
	for i in range(MovementManager.command_list.size() - 2) :
		position.y += 52.0
		await get_tree().create_timer(0.5).timeout
	hide()
	position = original_position
