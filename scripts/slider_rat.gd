extends CharacterBody2D

const SPEED = 600.0
const GRID_UNIT = 120
@onready var level_end: Control = %Level_End
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target_position: Vector2
var moving = false
var move_direction = Vector2.ZERO
@onready var up_slider: HSlider = $Camera2D/window/editor/UpSlider
@onready var down_slider: HSlider = $Camera2D/window/editor/DownSlider
@onready var right_slider: HSlider = $Camera2D/window/editor/RightSlider
@onready var left_slider: HSlider = $Camera2D/window/editor/LeftSlider
@onready var level_timer: Control = %LevelTimer
@onready var star_1: Sprite2D = $Camera2D/Level_End/star1
@onready var star_2: Sprite2D = $Camera2D/Level_End/star2
@onready var star_3: Sprite2D = $Camera2D/Level_End/star3
@onready var step_label: Label = $Camera2D/window/StepLabel
@onready var timelabel: Label = $Camera2D/Level_End/timelabel
var level_over = false

var steps_made = 0


func move():
			if not level_over:
				steps_made += 1
			step_label.text = "Steps %d" % steps_made
			timelabel.text = "%d steps!" % steps_made
			if right_slider.visible == false || randi_range(0,1) == 0:
				var rand = randi_range(0,100)
				if rand < up_slider.value:
					try_start_move(Vector2.UP)
					animated_sprite_2d.play("up")
				elif rand < up_slider.value + down_slider.value:
					try_start_move(Vector2.DOWN)
					animated_sprite_2d.play("down")
			else:
				var rand = randi_range(0,100)
				if rand < right_slider.value:
					try_start_move(Vector2.RIGHT)
					animated_sprite_2d.play("right")
				elif rand < left_slider.value + right_slider.value:
					try_start_move(Vector2.LEFT)
					animated_sprite_2d.play("left")


func _physics_process(delta):

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
	level_over = true
	#var m = int (level_timer.total_time_seconds / 60)
	#var s = level_timer.total_time_seconds - m * 60
	#$Camera2D/Level_End/timelabel.text = '%02d:%02d' % [m, s]
	var current_level = LevelManager.current_level
	
	match current_level:
		2:
			if steps_made > 30:
				star_1.texture = preload("res://assets/empty_star.png")
				star_2.texture = preload("res://assets/empty_star.png")
				star_3.texture = preload("res://assets/empty_star.png")
			elif steps_made > 25:
				star_1.texture = preload("res://assets/full_star.png")
				star_2.texture = preload("res://assets/empty_star.png")
				star_3.texture = preload("res://assets/empty_star.png")
			elif steps_made > 20:
				star_1.texture = preload("res://assets/full_star.png")
				star_2.texture = preload("res://assets/full_star.png")
				star_3.texture = preload("res://assets/empty_star.png")
			else:
				star_1.texture = preload("res://assets/full_star.png")
				star_2.texture = preload("res://assets/full_star.png")
				star_3.texture = preload("res://assets/full_star.png")
		3:
			if steps_made > 100:
				star_1.texture = preload("res://assets/empty_star.png")
				star_2.texture = preload("res://assets/empty_star.png")
				star_3.texture = preload("res://assets/empty_star.png")
			elif steps_made > 60:
				star_1.texture = preload("res://assets/full_star.png")
				star_2.texture = preload("res://assets/empty_star.png")
				star_3.texture = preload("res://assets/empty_star.png")
			elif steps_made > 35:
				star_1.texture = preload("res://assets/full_star.png")
				star_2.texture = preload("res://assets/full_star.png")
				star_3.texture = preload("res://assets/empty_star.png")
			else:
				star_1.texture = preload("res://assets/full_star.png")
				star_2.texture = preload("res://assets/full_star.png")
				star_3.texture = preload("res://assets/full_star.png")
	level_end.visible = true


func _on_run_button_pressed() -> void:
	level_over = false
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
	move()
	await get_tree().create_timer(0.5).timeout
