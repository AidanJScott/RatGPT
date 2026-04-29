extends Control

func _ready():
	$HBoxContainer/Visual/Settings/ColourBlindDropdown.selected = LevelManager._get_colorblind()
	var brightness = GlobalEnvironment.environment.adjustment_brightness
	$HBoxContainer/Visual/Settings/BrightnessSlider.value = brightness
	if get_parent().name == "PauseMenu":
		modulate = Color(brightness, brightness, brightness, 1.0)

func _on_back_pressed() -> void:
	# Return to MM if parent isn't pause menu, otherwise yield back to pause menu
	if get_parent().name == "PauseMenu":
		self.visible = false
	else:
		get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")

func _on_master_slider_value_changed(value: float) -> void:
	var bus_id = AudioServer.get_bus_index("Master")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_id, db)

func _on_music_slider_value_changed(value: float) -> void:
	var bus_id = AudioServer.get_bus_index("Music")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_id, db)

func _on_sfx_slider_value_changed(value: float) -> void:
	var bus_id = AudioServer.get_bus_index("SFX")
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_id, db)


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_brightness_slider_value_changed(value: float) -> void:
	GlobalEnvironment.environment.adjustment_brightness = value
	for node in get_tree().get_nodes_in_group("world_environment"):
		node.environment.adjustment_enabled = true
		node.environment.adjustment_brightness = value
	if get_parent().name == "PauseMenu":
		modulate = Color(value, value, value, 1.0)


func _on_colour_blind_dropdown_item_selected(index: int) -> void:
	# 0 default, 1 deut, 2 prot, 3 trit
	LevelManager._set_colorblind(index)
	$HBoxContainer/Visual/Settings/cheese.updateShader()


func _on_reset_pressed() -> void:
	$ResetConfirm/ResetButton.visible = false
	$ResetConfirm.visible = true
	await get_tree().create_timer(3.0).timeout
	if $ResetConfirm.visible:
		$ResetConfirm/ResetButton.visible = true

func _on_reset_button_pressed() -> void:
	$ResetConfirm/ResetButton.visible = false
	$ResetConfirm.visible = false
	LevelManager._reset_save_progress()
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")

func _on_cancel_button_pressed() -> void:
	$ResetConfirm/ResetButton.visible = false
	$ResetConfirm.visible = false
