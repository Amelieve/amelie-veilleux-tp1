extends CharacterBody2D

@export var speed : float =200
@export var jump_velocity : float = 400  

var anim_sprite : AnimatedSprite2D
var gravity : float = 1200   
var meow_sound : AudioStreamPlayer2D


func _ready() -> void:
	anim_sprite = $AnimatedSprite2D
	anim_sprite.play("idle")

func _physics_process(delta: float) -> void:
	var input_direction = Vector2.ZERO


	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
		anim_sprite.flip_h = true
	elif Input.is_action_pressed("move_left"):
		input_direction.x -= 1
		anim_sprite.flip_h = false

	velocity.x = input_direction.x * speed

	# Gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity 
		anim_sprite.play("jump")


	elif Input.is_action_pressed("sit") and is_on_floor():
		anim_sprite.play("sit")


	elif Input.is_action_just_pressed("attack"):
		anim_sprite.play("attack")

	
	# Marche
	elif is_on_floor() and velocity.x != 0:
		anim_sprite.play("walk")

	# Idle
	elif is_on_floor() and velocity.x == 0:
		anim_sprite.play("idle")

	# Appliquer le mouvement
	move_and_slide()
	
