extends Button
@onready var empty_block: TextureRect = $"../block_scroll/command_blocks/empty_block"
@onready var command_blocks: Control = $"../block_scroll/command_blocks"
var reset_empty_block

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_empty_block = empty_block.duplicate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	#remove all command blocks
	for block in command_blocks.get_children():
		command_blocks.remove_child(block)
		block.queue_free()
	
	# add empty command block
	command_blocks.add_child(reset_empty_block)
	
	# reset the empty block placeholder
	empty_block = command_blocks.get_child(0)
	reset_empty_block = empty_block.duplicate()
