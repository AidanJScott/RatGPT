extends Node2D

const SPEED = 5
var direction = "up"
var right_weight = 0.5
var left_weight = 0.5
var around_weight = 0.5
var chance_of_turning = 0.01

@onready var raycasts: Node2D = $raycasts
@onready var forward_cast: RayCast2D = $raycasts/forward_cast
@onready var left_cast: RayCast2D = $raycasts/left_cast
@onready var right_cast: RayCast2D = $raycasts/right_cast
@onready var left_weight_number = %left_weight_number
@onready var right_weight_number = %right_weight_number
@onready var back_weight_number = %back_weight_number
@onready var random_turn_number = %random_turn_number
@onready var cheese = %cheese

func _ready():
	cheese.cheesed.connect(cheese_collected)

func cheese_collected():
	%Level_End.visible = true
	%VictorySFX.play()

func _physics_process(delta):
	if direction == "up":
		position.y = position.y - SPEED*delta
	elif direction == "down":
		position.y = position.y + SPEED*delta
	elif direction == "left":
		position.x = position.x - SPEED*delta
	if direction == "right":
		position.x = position.x + SPEED*delta
	
	if forward_cast.is_colliding():
		turn_guarenteed()
	else:
		var randomc = randf()
		if randomc <= chance_of_turning:
			turn_not_guarenteed()
		
func turn_guarenteed():
	var random = randf_range(0, right_weight+left_weight+around_weight)
	if random <= right_weight:
		if not right_cast.is_colliding():
			turn_right()
		elif not left_cast.is_colliding() && left_weight >= around_weight:
			turn_left()
		else:
			turn_around()
	elif random <= right_weight+left_weight:
		if not left_cast.is_colliding():
			turn_left()
		elif not right_cast.is_colliding() && right_weight >= around_weight:
			turn_right()
		else:
			turn_around()
	else:
		turn_around()
		
func turn_not_guarenteed():
		var random = randf_range(0, right_weight+left_weight+around_weight)
		if random <= right_weight:
			if not right_cast.is_colliding():
				turn_right()
		elif random <= right_weight+left_weight:
			if not left_cast.is_colliding():
				turn_left()
		else:
			turn_around()


func turn_right():
	if direction == "up":
		direction = "right"
	elif direction == "right":
		direction = "down"
	elif direction == "down":
		direction = "left"
	elif direction == "left":
		direction = "up"
	$AnimatedSprite2D.animation = direction
	raycasts.rotate(deg_to_rad(90))
	$Area2D.rotate(deg_to_rad(90))

func turn_left():
	if direction == "up":
		direction = "left"
	elif direction == "right":
		direction = "up"
	elif direction == "down":
		direction = "right"
	elif direction == "left":
		direction = "down"
	$AnimatedSprite2D.animation = direction
	raycasts.rotate(deg_to_rad(-90))
	$Area2D.rotate(deg_to_rad(-90))
		
func turn_around():
	if direction == "up":
		direction = "down"
	elif direction == "right":
		direction = "left"
	elif direction == "down":
		direction = "up"
	elif direction == "left":
		direction = "right"
	$AnimatedSprite2D.animation = direction
	raycasts.rotate(deg_to_rad(180))
	$Area2D.rotate(deg_to_rad(180))


func _on_right_weight_slider_value_changed(value: float) -> void:
	right_weight = value/100.0
	right_weight_number.text = "%.2f" % right_weight


func _on_left_weight_slider_value_changed(value: float) -> void:
	left_weight = value/100.0
	left_weight_number.text = "%.2f" % left_weight


func _on_around_weight_slider_value_changed(value: float) -> void:
	around_weight = value/100.0
	back_weight_number.text = "%.2f" % around_weight


func _on_random_turn_chance_value_changed(value: float) -> void:
	chance_of_turning = value/5000.0
	random_turn_number.text = "%.4f" % chance_of_turning
