extends TextureRect
@onready var panel: Panel = $Panel
var command = ""


func _get_drag_data(at_position):
	if MovementManager.is_running:
		return null
	if texture == null:
		return null

	var preview_texture = TextureRect.new()
	preview_texture.texture = texture

	var preview = Control.new()
	preview.add_child(preview_texture)

	set_drag_preview(preview)

	var drag_texture = texture
	queue_free()

	return drag_texture

func _can_drop_data(_pos, data):
	return data is Texture2D

func _drop_data(_pos, data):
	texture = data
	
	command = texture.resource_path.get_file().get_basename()
	
	# clone node only if there isn't already a trailing empty block
	var siblings = get_parent().get_children()
	var last = siblings[siblings.size() - 1]
	if not ("command" in last) or last.command != "":
		var clone = preload("res://aidan/scenes/empty_block.tscn").instantiate()
		get_parent().add_child(clone)
		clone.layout_mode = 2
	
	
	# remove current border
	var stylebox = panel.get_theme_stylebox("panel").duplicate()
	stylebox.border_width_left = 0
	stylebox.border_width_right = 0
	stylebox.border_width_top = 0
	stylebox.border_width_bottom = 0
	add_theme_stylebox_override("panel", stylebox)
