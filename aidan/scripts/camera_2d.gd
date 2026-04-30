extends Camera2D

var zoom_speed = 0.1
var min_zoom = Vector2(0.5, 0.5)
var max_zoom = Vector2(2.0, 2.0)

func _ready():
	var story = get_tree().root.find_child("story_*", true, false)
	if story and story.visible:
		while story.visible:
			await get_tree().process_frame

	var tutorial = get_tree().root.find_child("tutorial_screen", true, false)
	if tutorial and tutorial.visible:
		while tutorial.visible:
			await get_tree().process_frame

	_center_on_maze()

func _center_on_maze():
	top_level = true
	var tile_map = get_tree().root.find_child("maze_tiles", true, false)
	if not tile_map:
		return

	# Find the layer named "Maze" to avoid the background which extends beyond the playable area
	var maze_layer := -1
	for i in tile_map.get_layers_count():
		if tile_map.get_layer_name(i).to_lower() == "maze":
			maze_layer = i
			break

	var cells: Array[Vector2i] = []
	if maze_layer >= 0:
		cells = tile_map.get_used_cells(maze_layer)

	if cells.is_empty():
		# Fall back to full used rect if no Maze layer found
		var used_rect = tile_map.get_used_rect()
		var center_tile = used_rect.position + used_rect.size / 2
		global_position = tile_map.global_position + tile_map.map_to_local(center_tile)
		return

	var min_cell = cells[0]
	var max_cell = cells[0]
	for cell in cells:
		min_cell = Vector2i(min(min_cell.x, cell.x), min(min_cell.y, cell.y))
		max_cell = Vector2i(max(max_cell.x, cell.x), max(max_cell.y, cell.y))

	var center_tile = (min_cell + max_cell) / 2
	global_position = tile_map.global_position + tile_map.map_to_local(center_tile)

func _input(event):
	if event.is_action_pressed("zoom_in"):
		zoom -= Vector2(zoom_speed, zoom_speed)
		zoom = zoom.max(min_zoom)

	if event.is_action_pressed("zoom_out"):
		zoom += Vector2(zoom_speed, zoom_speed)
		zoom = zoom.min(max_zoom)
