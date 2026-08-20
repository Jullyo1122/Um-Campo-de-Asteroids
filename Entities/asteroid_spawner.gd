extends Node2D

@export var asteroid_scene: PackedScene

func _on_timer_timeout():
	var asteroid = asteroid_scene.instantiate()

	var screen_size = get_viewport_rect().size

	asteroid.position = Vector2(
		randf_range(0, screen_size.x),
		-100
	)

	var scale = randf_range(3.0, 4.0)
	asteroid.scale = Vector2(scale, scale)

	$"../Asteroids".add_child(asteroid)
