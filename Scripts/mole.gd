extends AnimatedSprite2D

@export var mole_life: int = 3

func _on_hit_box_body_entered(body: Node2D) -> void:
	
	if body.name == "Ball":
		mole_life = mole_life - 1
		print(mole_life)
		
	if mole_life < 1:
		queue_free()
		
