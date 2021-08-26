extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	



func _on_Area2D_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("Player"):
		body.coin_collected()
		queue_free()
	pass # Replace with function body.
