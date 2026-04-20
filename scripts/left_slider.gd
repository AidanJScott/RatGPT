extends HSlider
@onready var left_label: Label = $"../LeftLabel"
@onready var line_5: ColorRect = $"../Net_Example/line5"
@onready var line_3: ColorRect = $"../Net_Example/line3"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_right_slider_value_changed(other_value: float) -> void:
	value = 100 - other_value


func _on_value_changed(value: float) -> void:
	left_label.text = "Left %d" % value
	line_5.size.y = 10 + value/10.0
	line_3.size.y = 10 + value/10.0
