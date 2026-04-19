extends Node
@onready var character_body_2d: CharacterBody2D = $"../CharacterBody2D"
var moves = 0
var command_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	command_list = ["up", "right", "down", "left", "up", "right", "down", "left", "up", "right", "down", "left"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		execute_movement(command_list)

func execute_movement(command_list):
	for command in command_list:
		move_direction(command)
		await get_tree().create_timer(0.5).timeout
	return

func move_direction(direction: String):
	if direction == "up":
		character_body_2d.try_start_move(Vector2.UP)
	elif direction == "down":
		character_body_2d.try_start_move(Vector2.DOWN)
	elif direction == "left":
		character_body_2d.try_start_move(Vector2.LEFT)
	elif direction == "right":
		character_body_2d.try_start_move(Vector2.RIGHT)
	return

func add_command(command: String):
	command_list.append(command)
	return

func delete_last_command():
	command_list = command_list.slice(0, command_list.size() - 1)
	return
	
