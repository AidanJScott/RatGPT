extends CharacterBody2D

const SPEED = 600.0
const GRID_UNIT = 120
@onready var level_end: Control = %Level_End
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target_position: Vector2
var moving = false
var move_direction = Vector2.ZERO
@onready var up_slider: HSlider = $Camera2D/window/editor/UpSlider
@onready var level_timer: Control = %LevelTimer
@onready var star_1: Sprite2D = $Camera2D/Level_End/star1
@onready var star_2: Sprite2D = $Camera2D/Level_End/star2
@onready var star_3: Sprite2D = $Camera2D/Level_End/star3

func _physics_process(delta):

	if not moving:
		if Input.is_action_just_pressed("up"):
			var rand = randi_range(0,100)
			if rand < up_slider.value:
				try_start_move(Vector2.UP)
				animated_sprite_2d.play("up")
			else:
				try_start_move(Vector2.DOWN)
				animated_sprite_2d.play("down")

	if moving:
		velocity = move_direction * SPEED
		move_and_slide()
		
		# stops movement on last pixel
		if position.distance_to(target_position) <= 1: 
			position = target_position
			stop_move()


func try_start_move(direction: Vector2):
	# uses test_only parameter for checking if collision occurs
	var space_check = move_and_collide(direction * GRID_UNIT, true)
	
	if space_check == null:
		move_direction = direction
		target_position = position + direction * GRID_UNIT
		moving = true


func stop_move():
	velocity = Vector2.ZERO
	moving = false

func level_ends():
	if level_timer.total_time_seconds > 20:
		star_1.texture = preload("res://assets/empty_star.png")
		star_2.texture = preload("res://assets/empty_star.png")
		star_3.texture = preload("res://assets/empty_star.png")
	elif level_timer.total_time_seconds > 10:
		star_1.texture = preload("res://assets/full_star.png")
		star_2.texture = preload("res://assets/empty_star.png")
		star_3.texture = preload("res://assets/empty_star.png")
	elif level_timer.total_time_seconds > 5:
		star_1.texture = preload("res://assets/full_star.png")
		star_2.texture = preload("res://assets/full_star.png")
		star_3.texture = preload("res://assets/empty_star.png")
	else:
		star_1.texture = preload("res://assets/full_star.png")
		star_2.texture = preload("res://assets/full_star.png")
		star_3.texture = preload("res://assets/full_star.png")
	level_end.visible = true
