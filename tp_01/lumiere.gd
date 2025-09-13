extends Area2D

@export var sound : AudioStreamPlayer2D
@export var light : Light2D
@export var etincelle : AnimatedSprite2D

func _ready() -> void:
	
	if not sound:
		sound = $"../AudioStreamPlayer2D"
	if not light:
		light = $"../Light2D"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if sound:
			sound.play()
		if light:
			light.enabled = not light.enabled  
		print("💡 Lumière activée")
		
	
func _etincelle(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# jouer le son
		if sound:
			sound.play()

		# toggle lumière
		if light:
			light.enabled = not light.enabled  

		# lancer étincelles
		if etincelle:
			etincelle.visible = true
			etincelle.play("etincelle")   # ⚠️ assure-toi que l’anim s’appelle bien "spark" dans SpriteFrames
			await etincelle.animation_finished
			etincelle.visible = false

		print("💡 Lumière cliquée + étincelles !")
