extends Node2D
onready var player = get_node("Player")
onready var enemy1 = preload("res://Characters/Enemy1.tscn")
onready var enemy2 = preload("res://Characters/Enemy2.tscn")
onready var enemy3 = preload("res://Characters/Enemy3.tscn")
onready var enemy4 = preload("res://Characters/Enemy4.tscn")
onready var coin = preload("res://Characters/Coin.tscn")
#var exit_door = preload("res://Walker Level Generation/Exit.tscn")
var borders = Rect2(1, 1, 38, 21)
const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN,
Vector2(1,1), Vector2(-1, 1), Vector2(-1, -1), Vector2(1, -1)]

onready var tilemap = get_node("TileMap")



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(1, 1), borders)
	var map = walker.walk(250)
	
	for location in map:
		tilemap.set_cellv(location, 1)
		var coin_instance = coin.instance()
		add_child(coin_instance)
		coin_instance.position = Vector2(location.x*32+16, location.y*32+16)
		player.add_coins()
		for direction in DIRECTIONS:
			if tilemap.get_cellv(location + direction) == -1:
				tilemap.set_cellv(location + direction, 0)
				
	#var exit_door_instance = exit_door.instance()
	#add_child(exit_door_instance)
	#exit_door_instance.position = walker.get_end_room().position * 32
	#exit_door_instance.connect("leaving_level", self, "reload_level")
	tilemap.set_up_pathfinding()
	
	var enemy1_instance = enemy1.instance()
	var enemy2_instance = enemy2.instance()
	var enemy3_instance = enemy3.instance()
	var enemy4_instance = enemy4.instance()
	add_child(enemy1_instance)
	add_child(enemy2_instance)
	add_child(enemy3_instance)
	add_child(enemy4_instance)
	enemy1_instance.position = map[randi() % map.size()] * 32
	enemy2_instance.position = map[randi() % map.size()] * 32
	enemy3_instance.position = map[randi() % map.size()] * 32
	enemy4_instance.position = map[randi() % map.size()] * 32
	walker.queue_free()



func reload_level():
	get_tree().reload_current_scene()
