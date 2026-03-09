extends Camera2D


# Define zoom speed and limits
var zoom_speed = 0.1
var min_zoom = Vector2(0.5, 0.5) # Zoom in limit (smaller values zoom in further)
var max_zoom = Vector2(2.0, 2.0) # Zoom out limit (larger values zoom out further)

func _input(event):
	if event.is_action_pressed("zoom_in"):
		zoom -= Vector2(zoom_speed, zoom_speed)
		zoom = zoom.max(min_zoom)
	
	if event.is_action_pressed("zoom_out"):
		zoom += Vector2(zoom_speed, zoom_speed)
		zoom = zoom.min(max_zoom)
