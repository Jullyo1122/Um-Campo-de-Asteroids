extends Node2D

@export var star_scene: PackedScene

func _on_timer_timeout():
	var star = star_scene.instantiate()

	var screen_size = get_viewport_rect().size

	star.position = Vector2(
		randf_range(0, screen_size.x),
		-50
	)

	$"../Stars".add_child(star)
