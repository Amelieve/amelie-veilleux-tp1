extends Area2D

@export var sound : AudioStreamPlayer2D

func _ready() -> void:
	if not sound:
		sound = $"../AudioStreamPlayer2D"   

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if sound:
			sound.play()
		print("😺 Le chat a été cliqué !")
