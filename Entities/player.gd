extends CharacterBody2D

signal jogador_morreu

@export var SPEED: float = 300.0

@onready var sprite = $Sprite2D
@onready var explosion = $Explosion
@onready var collision_shape = $CollisionShape2D
@onready var sound_explosion = $SoundExplosion

var dead = false

func _physics_process(delta):
	if dead:
		return

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
	
func aumentar_velocidade(nivel_atual: int):
	# Aumenta 20 de velocidade a cada nível. Ajuste esse valor como preferir.
	SPEED = 300.0 + ((nivel_atual - 1) * 60.0)
	print("Nova velocidade do jogador: ", SPEED)


func die():
	if dead:
		return

	dead = true

	velocity = Vector2.ZERO

	sprite.hide()
	
	sound_explosion.play()
	
	collision_shape.set_deferred("disabled", true)

	explosion.show()
	explosion.play("default")
	
	jogador_morreu.emit()
