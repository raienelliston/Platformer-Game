class_name CharacterStats
extends Resource

signal color_changed

enum CharacterColors {Red, Blue, White, Black}

@export var starting_color: CharacterColors

var character_color: CharacterColors : set = change_color

func change_color(color: CharacterColors) -> void:
	character_color = color
	color_changed.emit()

func get_color():
	return character_color
