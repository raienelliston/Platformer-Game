extends Area2D

@export var target_color: Character.CharacterColors
	
func _on_body_entered(body):
	if body.is_in_group("character"):
		print("character touched me")
		var character = body
		if character:
			character.set_color(target_color)
