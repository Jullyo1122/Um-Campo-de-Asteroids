extends Node2D

var survival_time: float = 0.0
var difficulty_level: int = 1

@onready var asteroid_timer = $AsteroidSpawner/Timer

func _process(delta):
	survival_time += delta

	var new_level = int(survival_time / 10.0) + 1

	if new_level != difficulty_level:
		difficulty_level = new_level

		asteroid_timer.wait_time = max(
			0.2,
			1.0 - (difficulty_level - 1) * 0.1
		)

		print("Dificuldade aumentou! Nível: ", difficulty_level)
		get_tree().call_group("Player", "aumentar_velocidade", difficulty_level)
