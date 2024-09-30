extends Line2D
class_name trail_line

var queue: Array
@export var max_lenght: int

func _process(_delta): 
	var pos = _get_position()
	
	queue.push_front(pos)
	
	if queue.size() > max_lenght:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)

func _get_position():
	return get_global_mouse_position()
	
