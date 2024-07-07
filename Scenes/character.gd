extends CharacterBody2D

@export var speed = 400
@export var gravity = 20
@export var jump_power = -3000
@export var stats : CharacterStats

@onready var color_sprite: Sprite2D = $Sprite2D
@onready var texture_rect: TextureRect = $Sprite2D/TextureRect
var current_color: CharacterStats.CharacterColors

func _ready() -> void:
	add_to_group("character")

func set_character_stats(value: CharacterStats) -> void:
	
	if not stats.color_changed.is_connected(update_color):
		stats.color_changed.connect(update_color)

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

func update_color(color: CharacterStats.CharacterColors) -> void:
	current_color = color
	match current_color:
		CharacterStats.CharacterColors.Red:
			color_sprite.modulate = Color("red")
		CharacterStats.CharacterColors.Blue:
			color_sprite.modulate = Color("blue")
		CharacterStats.CharacterColors.White:
			color_sprite.modulate = Color("white")
		CharacterStats.CharacterColors.Black:
			color_sprite.modulate = Color("black")
		_:
			push_error("Tried to set color to a color not declared")

func _on_color_changed() -> void:
	update_color(stats.get_character_color())
