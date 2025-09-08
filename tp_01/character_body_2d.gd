extends CharacterBody2D
 

 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var meow: AudioStreamPlayer2D = $meow  
 
var speed: float = 200.0       # vitesse horizontale
var gravity: float = 600.0     # gravité qui attire vers le bas
var jump_force: float = -400.0 # force du saut


func _physics_process(delta):
	# Gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# petit reset quand au sol
		velocity.y = 0  

	# Mouvement horizontal
	var direction := 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1

	velocity.x = direction * speed

	# Saut
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	# Appliquer mouvement
	move_and_slide()

	# 🎬 Animation selon l’état
	if not is_on_floor():
		anim.play("jump")
	elif direction != 0:
		anim.play("walk")
	else:
		anim.play("idle")


func _ready():
	if anim and anim.sprite_frames:
		anim.play("idle")
	else:
		push_error("AnimatedSprite2D introuvable ou SpriteFrames manquant.")
 
func _process(delta):
	if Input.is_physical_key_pressed(KEY_Q):
		if anim.animation != "sit":
			if anim.sprite_frames.has_animation("sit"):
				anim.play("sit")
		return
 
 
	if not anim.is_playing() and anim.animation in ["jump", "attack"]:
		anim.play("idle")
	elif anim.animation not in ["idle", "jump", "attack"]:
		anim.play("idle")
 
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_SPACE:
			anim.play("jump")
 
		
		elif event.physical_keycode == KEY_Z:
			anim.play("attack")
 
		
		elif event.physical_keycode == KEY_E:
			if meow.stream:
				meow.play()
			#else:
				#push_error("Pas de son assigné au nœud 'meow'.")	 
