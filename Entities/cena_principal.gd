extends Node2D

var survival_time: float = 0.0
var difficulty_level: int = 1
var game_over: bool = false
var score: int = 0

@onready var asteroid_timer = $AsteroidSpawner/Timer
@onready var player = $Player
@onready var score_label = $HUD/ScoreLabel

func _ready():
	if player:
		player.jogador_morreu.connect(_on_jogador_morreu)
		
func _process(delta):
	
	if game_over:
		# Exemplo extra: Reinicia a partida se o jogador apertar a tecla "ui_accept" (Espaço/Enter)
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
		return
		
	survival_time += delta
	
	score = int(survival_time * 10)
	score_label.text = "Score: " + str(score)

	var new_level = int(survival_time / 10.0) + 1

	if new_level != difficulty_level:
		difficulty_level = new_level

		asteroid_timer.wait_time = max(
			0.2,
			1.0 - (difficulty_level - 1) * 0.1
		)

		print("Dificuldade aumentou! Nível: ", difficulty_level)
		get_tree().call_group("Player", "aumentar_velocidade", difficulty_level)

func _on_jogador_morreu():
	game_over = true
	asteroid_timer.stop() # Para o surgimento de novos asteroides
	score_label.text = "GAME OVER!\nPontuação Final: " + str(score) + "\n\nPressione ESPAÇO ou ENTER para reiniciar"
