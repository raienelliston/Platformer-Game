class_name CharacterStats
extends Resource

signal color_changed

enum CharacterColors { Red, Blue, White, Black }

@export var starting_color: CharacterColors 

var _character_color: CharacterColors = starting_color

func change_color(color: CharacterColors) -> void:
	_character_color = color
	color_changed.emit()

func get_color() -> Color:
	match _character_color:
		CharacterColors.Red:
			return Color("red")
		CharacterColors.Blue:
			return Color("blue")
		CharacterColors.White:
			return Color("white")
		CharacterColors.Black:
			return Color("black")
		_:
			push_error("Tried to set color to a color not declared")
			return Color("white")

func get_character_color() -> CharacterColors:
	return _character_color
