extends Area2D

@export var target_color: CharacterStats.CharacterColors
@export var detector_id: int
@export var stats : CharacterStats
	
var triggered := false
	
func _ready() -> void:
	add_to_group("detectors")
	
func _on_body_entered(body):
	if body.is_in_group("character"):
		var character = body
		if character.red_emitting == true:
			print("triggered")
			triggered = true



func _on_body_exited(body):
	if body.is_in_group("character"):
		print("untriggered")
		triggered = false
