extends Area2D

@export var target_color: CharacterStats.CharacterColors
	
func _on_body_entered(body):
	if body.is_in_group("character"):
		print("character touched me")
		var character = body
		character.character_stats.character_color(target_color)
