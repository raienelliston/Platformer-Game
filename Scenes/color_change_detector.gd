extends Area2D

@export var target_color: CharacterStats.CharacterColors
	
func _on_area_enetered(area):
	if area.in_in_group("characters"):
		var character = area
		character.character_stats.character_color(target_color)
