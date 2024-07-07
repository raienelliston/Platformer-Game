extends CharacterBody2D

@export var speed = 400
@export var gravity = 20
@export var defualt_jump_power = -2000

@onready var color_sprite: Sprite2D = $Sprite2D
@onready var texture_rect: TextureRect = $Sprite2D/TextureRect

enum CharacterColors { Red, Blue, Purple, Yellow, Green, White, Black }
@export var starting_color: CharacterColors 
var character_color: CharacterColors = starting_color
var jump_power = defualt_jump_power

func _ready() -> void:
	add_to_group("character")
	

func _physics_process(delta):
	velocity.x = 0
	
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	
	if not is_on_floor():
		velocity.y += gravity
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y += jump_power
		
	move_and_slide()
	move_and_collide(Vector2(0, gravity))

func update_color() -> void:
	
	# Reset jump if it isn't green
	if not character_color == CharacterColors.Green:
		jump_power = -200
	
	match character_color:
		CharacterColors.Red: # Become a power source (like redstone)
			color_sprite.modulate = Color("red")
		CharacterColors.Blue: # Passthrough blue + blue related objects
			color_sprite.modulate = Color("blue")
		CharacterColors.Purple:
			color_sprite.modulate = Color("Purple") # Passthrough with purple + purple related (intentionally confuse with blue)
		CharacterColors.Yellow:
			color_sprite.modulate = Color("yellow")
		CharacterColors.Green: # Increased jump value
			jump_power = -3000
			color_sprite.modulate = Color("green")
		CharacterColors.White:
			color_sprite.modulate = Color("white") # Light source for dark rooms
		CharacterColors.Black:
			color_sprite.modulate = Color("black")
		_:
			push_error("Tried to set color to a color not declared")

func set_color(color: CharacterColors) -> void:
	character_color = color
	update_color()
