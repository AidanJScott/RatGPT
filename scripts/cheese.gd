extends Area2D

#@export var dimmer_path : NodePath
#@onready var dimmer : ColorRect = get_node(dimmer_path)

func _on_body_entered(body: Node2D) -> void:
	print("Something entered:", body.name)
	if body.is_in_group("player"):
		body.level_ends()
