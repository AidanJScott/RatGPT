extends HSlider
@onready var right_label: Label = $"../RightLabel"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_slider_value_changed(other_value: float) -> void:
	value = 100 - other_value


func _on_value_changed(value: float) -> void:
	right_label.text = "Right %d" % value
