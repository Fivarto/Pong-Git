extends CharacterBody2D

var win_size : Vector2

const START_SPEED: int = 500
const ACCEL: int = 50

var speed: int
var dir: Vector2

const MAX_Y_VECTOR: float = 0.6

var rotation_value: float = 1

#Trails Variables
var queue : Array
@export var max_lenght: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().ball_in_scene = true
	print(speed)
	win_size = get_viewport_rect().size

func new_ball():
	
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

func random_direction():
	var new_dir:= Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	
	return new_dir.normalized() 

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	
	$sprite_ball.rotation += rotation_value * delta
	
	
	if collision:
		collider = collision.get_collider()
		if collider == $"../Player-Paddle" or collider == $"../CPU":
			$AudioStreamPlayer.play()
			rotation_value = rotation_value * -1
			speed += ACCEL
			dir = new_direction(collider)
			
			#Variação do som
			if $AudioStreamPlayer.playing == true:
				$AudioStreamPlayer.pitch_scale = randf_range(0.2 , 1.2)
			
		else:
			dir = dir.bounce(collision.get_normal())
			rotation_value = rotation_value * -1



func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir:= Vector2()
	
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	
	new_dir.y = (dist / (collider.paddle_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()

func slow_mo():
	pass
