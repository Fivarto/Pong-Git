extends Sprite2D

var score := [0 , 0] # [0] = Player, [1] CPU/Player 2

const PADDLE_SPEED: int = 500

var gameModePVP: bool = false
var gameModePVE: bool = false

var ball_scene = preload("res://Scenes/ball.tscn")

var ball_in_scene: bool = false


func _on_balltimer_timeout() -> void:
	$SlowZoneTimer.start()
	$Ball.new_ball()


#CPU Score
func _on_score_left_body_entered(body: Node2D) -> void:
	score[1] += 1
	$Ball.queue_free()
	ball_in_scene = false
	$"HUD/label-cpuScore".text = str(score[1])
	
	
	
	$Balltimer.start()
	
	if score[1] >= 1:
		print("CPU ganhou")
		$canvas_win_screen.visible = true
		$Balltimer.stop()

#Player Score
func _on_score_right_body_entered(body: Node2D) -> void:
	score[0] += 1
	$"HUD/label-playerScore".text = str(score[0])
	
	$Ball.queue_free()
	ball_in_scene = false
	$Balltimer.start()
	
	if score[0] >= 1:
		print("Player ganhou")
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
	
	$slow_zone.reset_slow_zone()
	$SlowZoneTimer.start()
