extends KinematicBody2D

var navigation
var player
var path
var velocity
export(int) var move_speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation = get_tree().get_nodes_in_group("Navigation")[0]
	player = get_tree().get_nodes_in_group("Player")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	generate_path()
	if player and navigation:
		generate_path()
		navigate()
	move()

func generate_path():
	var player_pos = navigation.world_to_map(player.global_position)
	var pos = navigation.world_to_map(global_position)
	path = navigation._get_path(pos, player_pos)

func navigate():
	if path.size() > 1:
		velocity = global_position.direction_to(Vector2(path[1][0]*32 + 16,path[1][1]*32 + 16)) * move_speed
		# If reached destination, remove this point from array

func move():
	velocity = move_and_slide(velocity)
