extends StaticBody2D

var win_height: int
var paddle_height: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_height = get_viewport_rect().size.y
	paddle_height = $Sprite2D.texture.get_height()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("p1_move_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
		
	elif Input.is_action_pressed("p1_move_down"):
		position.y += get_parent().PADDLE_SPEED * delta
	
	#if Input.is_action_just_pressed("p1_power_up"):
	#	pass
	
	position.y = clamp(position.y, paddle_height / 2, win_height - paddle_height / 2)
