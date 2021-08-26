extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var astar = AStar2D.new()
onready var used_cells = get_used_cells_by_id(1)

var path : PoolVector2Array

func _input(event):
	"""
	if (event is InputEventMouseButton and event.is_pressed()):
			var mouse_pos = world_to_map(get_global_mouse_position())
			if used_cells.has(mouse_pos):
				var player_pos = world_to_map(Vector2(0,0))
				path = _get_path(Vector2(0,0), mouse_pos)
				print("Player position: " + str(world_to_map(player_pos)))
				print("Mouse position: " + str(world_to_map(mouse_pos)))
				print("Path: " + str(path))
				print(".........")
	"""

# Called when the node enters the scene tree for the first time.
func _ready():
	add_points()
	connect_points()
	#_connect_diagonal_points()


func add_points():
	for cell in used_cells:
		astar.add_point(id(cell), cell, 1.0)

func connect_points():
	for cell in used_cells:
		# RIGHT, LEFT, DOWN, UP
		var neighbours = [Vector2(1,0), Vector2(-1,0), Vector2(0, 1), Vector2(0, -1)]
		for neighbour in neighbours:
			var next_cell = cell + neighbour
			#print(cell, next_cell, (used_cells.has(next_cell)))
			if used_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell), false)


func _get_path(start, end):
	path = astar.get_point_path(id(start), id(end))
	#draw_path()
	return path

func draw_path():
	var line2d = get_node("Line2D")
	line2d.clear_points()
	var drawed_path = PoolVector2Array()
	for cell in path:
		line2d.add_point((Vector2(cell.x * 32 + 16, cell.y * 32 + 16)))
	

# Cantor pairing function, Calculates unique ID when given point with x,y values
func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b

func _connect_diagonal_points():
	for cell in used_cells:
		# RIGHT, LEFT, DOWN, UP
		var neighbours = [Vector2(1,1), Vector2(1,-1), Vector2(-1, 1), Vector2(-1, -1)]
		for neighbour in neighbours:
			var next_cell = cell + neighbour
			#print(cell, next_cell, (used_cells.has(next_cell)))
			if used_cells.has(next_cell):
				astar.connect_points(id(cell), id(next_cell), false)
