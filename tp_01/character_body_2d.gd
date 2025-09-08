extends CharacterBody2D

@export var speed : float = 200
@export var jump_velocity : float = 400   # Note : positif vers le haut pour Godot 4

var anim_sprite : AnimatedSprite2D
var gravity : float = 1200   # Ajuste selon ta scène

func _ready() -> void:
	anim_sprite = $AnimatedSprite2D
	anim_sprite.play("idle")

func _physics_process(delta: float) -> void:
	var input_direction = Vector2.ZERO

	# Déplacement horizontal
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
		anim_sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		input_direction.x -= 1
		anim_sprite.flip_h = true

	velocity.x = input_direction.x * speed

	# Gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # réinitialise la vitesse verticale quand au sol

	# Saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity  # négatif pour sauter vers le haut
		anim_sprite.play("jump")

	# S'assoir
	elif Input.is_action_pressed("sit") and is_on_floor():
		anim_sprite.play("sit")

	# Attaque
	elif Input.is_action_just_pressed("attack"):
		anim_sprite.play("attack")

	# Idle si aucune action
	elif is_on_floor() and velocity.x == 0 and not anim_sprite.is_playing():
		anim_sprite.play("idle")

	# Appliquer le mouvement
	move_and_slide()
