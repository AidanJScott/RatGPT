extends CharacterBody2D

@export var speed : float = 40.0
@export var vision_distance : float = 200.0
@export var vision_angle : float = 60.0
@export var tilemap : TileMapLayer
@onready var detection_area : Area2D = $Area2D

@onready var raycast : RayCast2D = $RayCast2D
@export var player : CharacterBody2D

enum State { IDLE, CHASE }
var state : State = State.IDLE

var repath_timer : float = 0.0
@export var repath_interval : float = 0.5  # seconds

var astar : AStarGrid2D
var path : PackedVector2Array
var path_index : int = 0

func _ready():
	print("Player found:", player)
	detection_area.body_entered.connect(_on_body_entered)
	if tilemap == null:
		push_error("TileMapLayer not assigned in Inspector!")
		return
	setup_astar()
	
func _on_body_entered(body):
	if body == player:
		print("Player touched enemy!")

# A* SETUP
func setup_astar():
	astar = AStarGrid2D.new()
	var used_rect = tilemap.get_used_rect()

	astar.region = used_rect
	astar.cell_size = tilemap.tile_set.get_tile_size()
	astar.offset = tilemap.map_to_local(Vector2i.ZERO)
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()

	for x in range(used_rect.size.x):
		for y in range(used_rect.size.y):

			var cell = Vector2i(
				x + used_rect.position.x,
				y + used_rect.position.y
			)

			if is_tile_blocked(cell):
				astar.set_point_solid(cell, true)

func is_tile_blocked(cell: Vector2i) -> bool:
	var tile_data = tilemap.get_cell_tile_data(cell)

	if tile_data == null:
		return false

	# If tile has collision polygons, treat it as a wall
	return tile_data.get_collision_polygons_count(0) > 0

func _physics_process(delta):
	calculate_path()
	follow_path()
	move_and_slide()

# PATHING
func calculate_path():
	var start = tilemap.local_to_map(global_position)
	var end = tilemap.local_to_map(player.global_position)

	var new_path = astar.get_point_path(start, end)
	if new_path.size() == 0:
		return
	
	if new_path != path:
		path = new_path
		path_index = 0

func follow_path():
	if path.is_empty():
		velocity = Vector2.ZERO
		return

	if path_index >= path.size():
		velocity = Vector2.ZERO
		return

	var target = path[path_index]
	var direction = target - global_position

	if direction.length() < 8:
		path_index += 1
		return

	velocity = direction.normalized() * speed

# VISION SYSTEM
func can_see_player() -> bool:
	if player == null:
		return false

	return global_position.distance_to(player.global_position) < 200
