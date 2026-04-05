extends CharacterBody2D

const SPEED = 600.0
const GRID_UNIT = 120

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var target_position: Vector2
var moving = false
var move_direction = Vector2.ZERO
@onready var up_slider: HSlider = $Camera2D/window/editor/UpSlider

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
