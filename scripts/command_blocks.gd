extends Node
var command_list = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	command_list = []
	for command_block in get_children():
		if "command" in command_block:
			command_list.append(command_block.command)
	
	MovementManager.command_list = command_list
	
