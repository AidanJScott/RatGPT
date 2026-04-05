extends HSlider
@onready var down_label: Label = $"../DownLabel"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_up_slider_value_changed(other_value: float) -> void:
	value = 100 - other_value


func _on_value_changed(value: float) -> void:
	down_label.text = "Down %d" % value
