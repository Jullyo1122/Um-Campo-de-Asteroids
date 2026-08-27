extends Node2D

var survival_time: float = 0.0
var difficulty_level: int = 1
var game_over: bool = false
var score: int = 0

const ICONE_PAUSE = preload("res://BGM e SFX/Design_sem_nome__5_-removebg-preview.png")
const ICONE_PLAY = preload("res://BGM e SFX/Design_sem_nome__6_-removebg-preview.png")

@onready var asteroid_timer = $AsteroidSpawner/Timer
@onready var player = $Player
@onready var score_label = $HUD/ScoreLabel
@onready var game_over_label = $HUD/GameOverLabel
@onready var menu_pause = $HUD/MenuPause
@onready var pause_button = $HUD/TextureButton 

func _ready():
	game_over_label.hide()
	menu_pause.hide()
	
	menu_pause.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_button.process_mode = Node.PROCESS_MODE_ALWAYS 
	
	if player:
		player.jogador_morreu.connect(_on_jogador_morreu)
	
	var master_bus = AudioServer.get_bus_index("Master")
	
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and not game_over: 
		toggle_pause()


func toggle_pause():
	if get_tree().paused:
		despausar_jogo()
	else:
		pausar_jogo()

func pausar_jogo():
	get_tree().paused = true
	menu_pause.show()
	pause_button.texture_normal = ICONE_PLAY

func despausar_jogo():
	get_tree().paused = false
	menu_pause.hide()
	pause_button.texture_normal = ICONE_PAUSE

func _on_texture_button_pressed():
	if not game_over:
		toggle_pause()

func _on_botao_continuar_pressed():
	despausar_jogo()

func _on_botao_reiniciar_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_voltarao_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/menu.tscn")

func _on_jogador_morreu():
	game_over = true
	asteroid_timer.stop() 
	pause_button.hide() 
	game_over_label.text = "GAME OVER!\nPontuação Final: " + str(score) + "\n\nPressione ESPAÇO ou ENTER para reiniciar"
	game_over_label.show()

func _process(delta):
	if game_over:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()
		return
		
	survival_time += delta
	score = int(survival_time * 10)
	score_label.text = "Score: " + str(score)

	var new_level = int(survival_time / 10.0) + 1

	if new_level != difficulty_level:
		difficulty_level = new_level
		asteroid_timer.wait_time = max(0.2, 1.0 - (difficulty_level - 1) * 0.1)
		get_tree().call_group("Player", "aumentar_velocidade", difficulty_level)
