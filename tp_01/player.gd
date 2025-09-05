extends Node2D


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var meow: AudioStreamPlayer2D = $meow





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


	#if not anim.is_playing() and anim.animation in ["jump", "attack"]:
		#anim.play("idle")
	#elif anim.animation not in ["idle", "jump", "attack"]:
		#anim.play("idle")

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		
		if event.physical_keycode == KEY_SPACE:
			anim.play("jump")

		
		elif event.physical_keycode == KEY_A:
			anim.play("attack")

func _son(event):
	if event is InputEventKey and event.pressed:
		if event.physical_keycode == KEY_E:
			meow.stream = load("res://assets/audio/meow.mp3")

			meow.stop() 
			meow.play()
