extends CharacterBody2D

const SPEED = 600.0
const GRID_UNIT = 120

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target_position: Vector2
var moving = false
var move_direction = Vector2.ZERO
var command_list = []
@onready var star_1: Sprite2D = $Camera2D/Level_End/star1
@onready var star_2: Sprite2D = $Camera2D/Level_End/star2
@onready var star_3: Sprite2D = $Camera2D/Level_End/star3
@onready var level_end: Control = %Level_End
#@onready var level_timer: Control = $Camera2D/window/LevelTimer
@onready var step_tracker: Control = $Camera2D/window/StepLabel

func _physics_process(delta):
	
	command_list = MovementManager.command_list

	if not moving:
		if Input.is_action_just_pressed("up"):
			try_start_move(Vector2.UP)
		elif Input.is_action_just_pressed("down"):
			try_start_move(Vector2.DOWN)
		elif Input.is_action_just_pressed("left"):
			try_start_move(Vector2.LEFT)
		elif Input.is_action_just_pressed("right"):
			try_start_move(Vector2.RIGHT)

	if moving:
		velocity = move_direction * SPEED
		move_and_slide()
		
		# stops movement on last pixel
		if position.distance_to(target_position) <= 1: 
			position = target_position
			stop_move()

func execute_movement():
	for command in command_list:
		move(command)
		await get_tree().create_timer(0.5).timeout
	return

func move(direction: String):
	if direction == "up":
		try_start_move(Vector2.UP)
	elif direction == "down":
		try_start_move(Vector2.DOWN)
	elif direction == "left":
		try_start_move(Vector2.LEFT)
	elif direction == "right":
		try_start_move(Vector2.RIGHT)
	return
	

func try_start_move(direction: Vector2):
	# uses test_only parameter for checking if collision occurs
	var space_check = move_and_collide(direction * GRID_UNIT, true)
	
	if space_check == null:
		MoveCounter.increase_step()
		move_direction = direction
		target_position = position + direction * GRID_UNIT
		moving = true
		if direction == Vector2.UP:
			animated_sprite_2d.play("up")
		elif direction == Vector2.DOWN:
			animated_sprite_2d.play("down")
		elif direction == Vector2.LEFT:
			animated_sprite_2d.play("left")
		elif direction == Vector2.RIGHT:
			animated_sprite_2d.play("right")

func cheese_collected():
	%Level_End.visible = true
	%VictorySFX.play()


func stop_move():
	velocity = Vector2.ZERO
	moving = false
	
func level_ends():
	#var m = int (level_timer.total_time_seconds / 60)
	#var s = level_timer.total_time_seconds - m * 60
	#$Camera2D/Level_End/timelabel.text = '%02d:%02d' % [m, s]
	var steps = MoveCounter._get_steps()
	LevelManager._save_steps(steps)
	$Camera2D/Level_End/timelabel.text = str(steps) + " Steps!"
	#if level_timer.total_time_seconds > 20:
	if steps > 40:
		star_1.texture = preload("res://assets/empty_star.png")
		star_2.texture = preload("res://assets/empty_star.png")
		star_3.texture = preload("res://assets/empty_star.png")
	#elif level_timer.total_time_seconds > 10:
	elif steps > 20:
		star_1.texture = preload("res://assets/full_star.png")
		star_2.texture = preload("res://assets/empty_star.png")
		star_3.texture = preload("res://assets/empty_star.png")
	#elif level_timer.total_time_seconds > 5:
	elif steps > 15:
		star_1.texture = preload("res://assets/full_star.png")
		star_2.texture = preload("res://assets/full_star.png")
		star_3.texture = preload("res://assets/empty_star.png")
	else:
		star_1.texture = preload("res://assets/full_star.png")
		star_2.texture = preload("res://assets/full_star.png")
		star_3.texture = preload("res://assets/full_star.png")
	level_end.visible = true
