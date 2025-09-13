extends Area2D

@export var sound : AudioStreamPlayer2D
@export var terre : Node2D   

func _ready() -> void:
	if not sound:
		sound = $"../AudioStreamPlayer2D"
	if not terre:
		terre = $"../Light2D"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if sound:
			sound.play()
		if terre:
			terre.visible = not terre.visible  
		print("🌍 Planète activée/désactivée")

func _fusee() -> void:
	var tween = create_tween()
	# tourne sur elle-même (360° = 2*PI en radians)
	tween.tween_property($Fusee, "rotation_degrees", 360.0, 5.0)
	tween.set_loops()  # recommence sans fin
