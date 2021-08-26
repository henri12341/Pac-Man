extends KinematicBody2D

var navigation
var player
var path

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
	print(path)

func navigate():
	pass

func move():
	pass
