class_name Character
extends CharacterBody2D

@export var speed = 400
@export var gravity = 20
@export var time_to_peak_jump : float
@export var time_to_fall_jump : float
@export var jump_height : float

@onready var color_sprite: Sprite2D = $Sprite2D
@onready var texture_rect: TextureRect = $Sprite2D/TextureRect
@onready var point_light_2d = $LightNode/PointLight2D
@onready var light_node = $PointLight2D
@onready var hidden_node = $HiddenNode

enum CharacterColors { Red, Orange, Yellow, Green, Blue, Purple, White, Black }
@export var starting_color: CharacterColors 
@onready var character_color := starting_color
var bouncy = false

# Jump Variables
@onready var starting_jump_height = jump_height
@onready var jump_velocity : float = ((-2.0 * jump_height) / time_to_peak_jump)
@onready var jump_gravity : float = ((2.0 * jump_height) / (time_to_peak_jump * time_to_peak_jump))
@onready var fall_gravity : float = ((2.0 * jump_height) / (time_to_fall_jump * time_to_fall_jump))

# Color Asssistance Variables
var red_emitting := false

func _ready() -> void:
	add_to_group("character")
	update_color()

func _physics_process(delta):
	if bouncy == false:
		if velocity.y < 0.0:
			velocity.y += jump_gravity * delta
		else:
			velocity.y += fall_gravity * delta
		
		velocity.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * speed
		
		if not is_on_floor():
			velocity.y += gravity
		if Input.is_action_just_pressed("up") and is_on_floor() and gravity > 0:
			velocity.y = jump_velocity
		elif Input.is_action_just_pressed("up") and is_on_ceiling() and gravity < 0:
			velocity.y = jump_velocity
		move_and_slide()
	else: # in the case that yellow/bouncy is enabled
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
	

func update_color() -> void:
	
	match character_color:
		CharacterColors.Red: # Become a power source (like redstone)
			bouncy = false
			gravity = 20
			light_node.visible = false
			red_emitting = true
			self.collision_mask = 1 | 2 | 3 
			jump_height = starting_jump_height
			color_sprite.modulate = Color("red")
			
		CharacterColors.Orange: # Passthrough blue + blue related objects
			bouncy = true
			gravity = 20
			light_node.visible = false
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_height = starting_jump_height
			color_sprite.modulate = Color("blue")
			
		CharacterColors.Yellow: # Bouncy. Gives character uncontrollable bouncy movment
			bouncy = true
			gravity = -20
			light_node.visible = false
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_height = starting_jump_height
			color_sprite.modulate = Color("yellow")
			
		CharacterColors.Green: # Increased jump value
			bouncy = false
			gravity = 20
			light_node.visible = false
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_height = starting_jump_height * 1.5
			color_sprite.modulate = Color("green")
			
		CharacterColors.Blue: # Passthrough blue + blue related objects
			bouncy = false
			gravity = 20
			light_node.visible = false
			red_emitting = false
			self.collision_mask = 1 | 2
			jump_height = starting_jump_height
			color_sprite.modulate = Color("blue")
			
		CharacterColors.Purple: # Passthrough with purple + purple related (intentionally confuse with blue)
			bouncy = false
			gravity = 20
			light_node.visible = false
			red_emitting = false
			self.collision_mask = 1 | 3
			jump_height = starting_jump_height
			color_sprite.modulate = Color("Purple")
			
		CharacterColors.White: # Light source for dark rooms
			bouncy = false
			gravity = 20
			light_node.visible = true
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_height = starting_jump_height
			color_sprite.modulate = Color("white")
			
		CharacterColors.Black: # Hidden Block?
			bouncy = false
			gravity = 20
			light_node.visible = false
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_height = starting_jump_height
			color_sprite.modulate = Color("black")
			
		_:
			push_error("Tried to set color to a color not declared")

func set_color(color: CharacterColors) -> void:
	if color != character_color:
		print("balls")
		character_color = color
		update_color()
