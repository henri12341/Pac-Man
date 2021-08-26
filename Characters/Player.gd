extends KinematicBody2D

export var move_speed : float = 200
var velocity : Vector2 = Vector2(0,0)
var coins_collected = 0
var max_coins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func coin_collected():
	max_coins -= 1
	if max_coins == 0:
		get_tree().reload_current_scene()
	#print("coin collected")

func add_coins():
	max_coins += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("Enemy"):
			get_tree().reload_current_scene()
	var input_dir = get_input_direction()
	velocity = move_speed * input_dir.normalized()
	velocity = move_and_slide(velocity)


func get_input_direction():

	var direction_x = 0
	var direction_y = 0
	if Input.is_action_pressed("move_right"):
		direction_x += 1
	if Input.is_action_pressed("move_left"):
		direction_x += -1
	if Input.is_action_pressed("move_down"):
		direction_y += 1
	if Input.is_action_pressed("move_up"):
		direction_y += -1
	
	return Vector2(direction_x, direction_y)

