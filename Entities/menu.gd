extends Control

@onready var menu_inicial = $MenuInicial
@onready var panel_settings = $Panel
@onready var button_toggle_som = $Panel/SecaoSom/ButtonToggleSom

var master_bus: int

func _ready():
	master_bus = AudioServer.get_bus_index("Master")
	panel_settings.hide()
	menu_inicial.show()
	button_toggle_som.set_pressed_no_signal(not AudioServer.is_bus_mute(master_bus))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Cenas/cena_principal.tscn")

func _on_settings_pressed():
	menu_inicial.hide()
	panel_settings.show()

func _on_botao_voltar_pressed():
	panel_settings.hide()
	menu_inicial.show()

func _on_button_toggle_som_toggled(toggled_on: bool):
	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus, not toggled_on)
