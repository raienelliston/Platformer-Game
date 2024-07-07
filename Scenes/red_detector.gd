extends Area2D

signal detected_signal

@export var detector_id: int
	
var triggered := false
	
func _ready() -> void:
	add_to_group("detectors")
	
func _on_body_entered(body):
	if body.is_in_group("character"):
		var character = body
		if character.red_emitting == true && triggered == false:
			print("triggered")
			triggered = true
			detected_signal.emit()

func _on_body_exited(body):
	if body.is_in_group("character"):
		print("untriggered")
		triggered = false
