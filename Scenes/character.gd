extends CharacterBody2D

@export var speed = 400
@export var gravity = 20
@export var jump_power = -3000

@onready var color_sprite: Sprite2D = $Sprite2D
@onready var texture_rect: TextureRect = $Sprite2D/TextureRect

enum CharacterColors {Red, Blue, White, Black}

var current_color: CharacterColors

func _ready() -> void:
	color_sprite.modulate = Color("red")

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

func set_color(color: CharacterColors):
	current_color = color
	match current_color:
		CharacterColors.Red:
			color_sprite.modulate = Color("red")
		CharacterColors.Blue:
			color_sprite.modulate = Color("blue")
		CharacterColors.White:
			color_sprite.modulate = Color("white")
		CharacterColors.Black:
			color_sprite.modulate = Color("black")
		_:
			push_error("Tried to set color to a color not declared")
