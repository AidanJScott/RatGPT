extends Area2D

@export var dimmer_path : NodePath
@onready var dimmer : ColorRect = get_node(dimmer_path)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Something entered:", body.name)
	if body.is_in_group("player"):
		trigger_exit()
		
func trigger_exit():
	print("Pausing game")
	get_tree().paused = true
	dimmer.visible = true
	dimmer.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(dimmer, "modulate:a", 0.6, 0.5)

	await tween.finished
	get_tree().paused = true
