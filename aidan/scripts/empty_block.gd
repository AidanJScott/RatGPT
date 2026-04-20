extends TextureRect
@onready var panel: Panel = $Panel
var command = ""


func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = texture
	
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	set_drag_preview(preview)
	
	# get rid of texture and revert to empty block
	
	texture = null
	command = ""
	var stylebox = panel.get_theme_stylebox("panel").duplicate()
	stylebox.border_width_left = 5
	stylebox.border_width_right = 5
	stylebox.border_width_top = 5
	stylebox.border_width_bottom = 5
	add_theme_stylebox_override("panel", stylebox)
	
	return preview_texture.texture

func _can_drop_data(_pos, data):
	return data is Texture2D

func _drop_data(_pos, data):
	texture = data
	
	command = texture.resource_path.get_file().get_basename()
	print(command)
	
	# clone node
	var clone = preload("res://aidan/scenes/empty_block.tscn").instantiate()
	get_parent().add_child(clone)
	clone.position = position + Vector2(0, 48)
	
	
	# remove current border
	var stylebox = panel.get_theme_stylebox("panel").duplicate()
	stylebox.border_width_left = 0
	stylebox.border_width_right = 0
	stylebox.border_width_top = 0
	stylebox.border_width_bottom = 0
	add_theme_stylebox_override("panel", stylebox)
