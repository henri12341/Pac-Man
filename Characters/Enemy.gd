extends KinematicBody2D

var navigation
var player
var path = Array()
var velocity = Vector2(0,0)
export(int) var move_speed = 50
var path_found = true
var directions = [Vector2(1,0), Vector2(-1,0), Vector2(0, 1), Vector2(0, -1)]
var timer = 0
var time_to_change_direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	navigation = get_tree().get_nodes_in_group("Navigation")[0]
	player = get_tree().get_nodes_in_group("Player")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	timer += delta
	if player and navigation:
		generate_path()
		navigate()
	move()

func generate_path():
	var player_pos
	if global_position.distance_to(player.global_position) < 8*32:
		player_pos = navigation.world_to_map(player.global_position)
		path_found = true
	else:
		path_found = false
		return
	var pos = navigation.world_to_map(global_position)
	
	path = navigation._get_path(pos, player_pos)
	#print(path)

func navigate():
	if path_found:
		if path.size() > 1:
			velocity = global_position.direction_to(Vector2(path[1][0]*32 + 16,path[1][1]*32 + 16)) * move_speed
	else:
		if timer > time_to_change_direction:
			timer = 0
			velocity = directions[randi() % 4] * move_speed
			time_to_change_direction = randi() % 3

func move():
	velocity = move_and_slide(velocity)
