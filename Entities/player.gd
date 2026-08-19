extends CharacterBody2D

@export var SPEED: float = 300.0

@onready var sprite = $Sprite2D

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = direction * SPEED
	velocity.y = 0
	
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	var half_width = sprite.texture.get_width() * sprite.scale.x / 2
	
	position.x = clamp(
		position.x,
		half_width,
		screen_size.x - half_width
	)
