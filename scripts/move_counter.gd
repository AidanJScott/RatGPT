extends Node

@export var step_label: Label

var step_count: int = 0

func increase_step(step: int = 1) -> void:
	step_count += step
	_update_label()

func reset_steps() -> void:
	step_count = 0
	_update_label()

func _update_label() -> void:
	if step_label:
		step_label.text = "Steps: " + str(step_count)
