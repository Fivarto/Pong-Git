extends Sprite2D

var score := [0 , 0] # [0] = Player, [1] CPU/Player 2

const PADDLE_SPEED: int = 500

var gameModePVP: bool = false
var gameModePVE: bool = false

var ball_scene = preload("res://Scenes/ball.tscn")
var slowMo_scene = preload("res://Scenes/slown_zone.tscn")
var mole_scene = preload("res://mole.tscn")

var ball_in_scene: bool = false

#Power Up Add
func _input(event):
	if event.is_action_pressed("p1_power_up"):
		$SlowZoneTimer.start()

func _on_balltimer_timeout() -> void:
	
	if not get_node("Ball"):
		var instancia = ball_scene.instantiate()
		add_child(instancia)
		
		$Ball.new_ball()
	
	else:
		$Ball.new_ball()


#CPU Score
func _on_score_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	$Ball.queue_free()
	ball_in_scene = false
	$"HUD/label-cpuScore".text = str(score[1])
	
	
	
	$Balltimer.start()
	
	if score[1] >= 3:
		$canvas_win_screen/VBoxContainer/label_win_screen.text = str(" A CPU VENCEU")
		$canvas_win_screen.visible = true
		$Balltimer.stop()

#Player Score
func _on_score_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	$"HUD/label-playerScore".text = str(score[0])
	
	$Ball.queue_free()
	ball_in_scene = false
	$Balltimer.start()
	
	if score[0] >= 3:
		$canvas_win_screen/VBoxContainer/label_win_screen.text = str(" O PLAYER VENCEU")
		$canvas_win_screen.visible = true
		$Balltimer.stop()

#Game Mode Player vs CPU Selecionado
func _on_button_player_xcpu_pressed() -> void:
	
	$canvas_gameMode.visible = false
	gameModePVE = true
	
	var instancia = ball_scene.instantiate()
	add_child(instancia)
	
	$Balltimer.start()

#Game Mode Player vs Player Selecionado
func _on_button_player_xplayer_pressed() -> void:
	
	$canvas_gameMode.visible = false
	gameModePVP = true
	
	var instancia = ball_scene.instantiate()
	add_child(instancia)
	
	$Balltimer.start()


#Voltar ao menu inicial
func _on_button_back_to_menu_pressed() -> void:
	
	gameModePVE = false
	gameModePVP = false
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


#Restart Game
func _on_button_restart_game_pressed() -> void:
	score[0] = 0
	score[1] = 0
	
	#gameModePVE = false
	#gameModePVP = false
	
	$"HUD/label-playerScore".text = str(score[0])
	$"HUD/label-cpuScore".text = str(score[1])
	
	var instancia = ball_scene.instantiate()
	add_child(instancia)
	
	$canvas_win_screen.visible = false
	$Balltimer.start()
	
	# $SlowZoneTimer.start()
	
	if get_node("SlowMoZone"):
		get_node("SlowMoZone").queue_free()


func _on_slow_zone_timer_timeout():
	
	
	var instancia_slow_mo = slowMo_scene.instantiate()
	instancia_slow_mo.position = Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2 )
	add_child(instancia_slow_mo)


#Back to Manu from Player Mode Select
func _on_button_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


#Spawn mole
func _on_mole_timer_timeout() -> void:
	
	
	var mole_instance = mole_scene.instantiate()
	mole_instance.position = Vector2(randf_range(get_viewport().size.x , 0), randf_range(get_viewport().size.y, 0))
	add_child(mole_instance)
