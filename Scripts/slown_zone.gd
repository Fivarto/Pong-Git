extends Area2D

var old_speed: int

var is_slow: bool = false

func _ready():
	
	old_speed = 500

func reset_slow_zone():
	
	$CollisionShape2D.disabled = true
	$".".visible = false

func _on_body_entered(body):
	
	old_speed = get_parent().get_node("Ball").speed
	
	if is_slow:
		body.speed = body.speed  / 2
		print("Entrou")
		print(body.speed)
		
		is_slow = false


func _on_body_exited(body):
	
	if not is_slow:
		
		body.speed = old_speed
		print("Saiu")
		print(body.speed)
		
		is_slow = true
