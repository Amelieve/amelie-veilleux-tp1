extends Node2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle") 

func _input(event):
	
	if event is InputEventKey and event.pressed and not event.echo:
		
		if event.keycode == KEY_SPACE:
			anim.play("jump")
		
	
		elif event.physical_keycode == KEY_A:
			anim.play("attack")

func _process(delta):
	
	if not anim.is_playing() and anim.animation in ["jump", "attack"]:
		anim.play("idle")


func _on_animated_sprite_2d_frame_changed():
	if anim.animation == "jump" and anim.frame == 1:
		anim.scale = Vector2(1.5, 1.5) 
	else:
		anim.scale = Vector2(1, 1)      
