extends StaticBody2D

var ball_pos: Vector2
var dist: int

var move_by: int
var win_height: int
var paddle_height: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_height = get_viewport_rect().size.y
	paddle_height = $Sprite2D.texture.get_height()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	#Player 2 no controle
	if $"..".gameModePVP == true:
		if Input.is_action_pressed("p2_move_up"):
			position.y -= get_parent().PADDLE_SPEED * delta
			
		elif Input.is_action_pressed("p2_move_down"):
			position.y += get_parent().PADDLE_SPEED * delta
	
	
	#CPU no controle
	if $"..".gameModePVE == true and get_parent().get_node("Ball"): #Colocar um sinal para substituir essa Bola
		ball_pos = $"../Ball".position
		dist = position.y - ball_pos.y
		
		if abs(dist) > get_parent().PADDLE_SPEED * delta:
			move_by =  get_parent().PADDLE_SPEED * delta * (dist / abs(dist))
		else:
			move_by = dist
		
		position.y -= move_by
	else:
		position.y = win_height / 2
	position.y = clamp(position.y, paddle_height / 2, win_height - paddle_height / 2)
