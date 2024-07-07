class_name Character
extends CharacterBody2D

@export var speed = 400
@export var gravity = 20
@export var defualt_jump_power = -2000

@onready var color_sprite: Sprite2D = $Sprite2D
@onready var texture_rect: TextureRect = $Sprite2D/TextureRect
@onready var point_light_2d = $LightNode/PointLight2D
@onready var light_node = $LightNode
@onready var hidden_node = $HiddenNode


enum CharacterColors { Red, Blue, Purple, Yellow, Green, White, Black, NONE }
@export var starting_color: CharacterColors 
var character_color: CharacterColors = CharacterColors.NONE
var jump_power = defualt_jump_power


# Color Asssistance Variables
var red_emitting := false

func _ready() -> void:
	add_to_group("character")
	set_color(starting_color)
	

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
	
	match character_color:
		CharacterColors.Red: # Become a power source (like redstone)
			point_light_2d.get_parent().remove_child(point_light_2d)
			hidden_node.add_child(point_light_2d)
			red_emitting = true
			self.collision_mask = 1 | 2 | 3 
			jump_power = -2000
			color_sprite.modulate = Color("red")
			
		CharacterColors.Blue: # Passthrough blue + blue related objects
			point_light_2d.get_parent().remove_child(point_light_2d)
			hidden_node.add_child(point_light_2d)
			red_emitting = false
			self.collision_mask = 1 | 2
			jump_power = -2000
			color_sprite.modulate = Color("blue")
			
		CharacterColors.Purple: # Passthrough with purple + purple related (intentionally confuse with blue)
			point_light_2d.get_parent().remove_child(point_light_2d)
			hidden_node.add_child(point_light_2d)
			red_emitting = false
			self.collision_mask = 1 | 3
			jump_power = -2000
			color_sprite.modulate = Color("Purple")
			
		CharacterColors.Yellow:
			point_light_2d.get_parent().remove_child(point_light_2d)
			hidden_node.add_child(point_light_2d)
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_power = -2000
			color_sprite.modulate = Color("yellow")
			
		CharacterColors.Green: # Increased jump value
			point_light_2d.get_parent().remove_child(point_light_2d)
			hidden_node.add_child(point_light_2d)
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_power = -3000
			color_sprite.modulate = Color("green")
			
		CharacterColors.White: # Light source for dark rooms
			point_light_2d.get_parent().remove_child(point_light_2d)
			light_node.add_child(point_light_2d)
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_power = -2000
			color_sprite.modulate = Color("white")
			
		CharacterColors.Black:
			point_light_2d.get_parent().remove_child(point_light_2d)
			hidden_node.add_child(point_light_2d)
			red_emitting = false
			self.collision_mask = 1 | 2 | 3
			jump_power = -2000
			color_sprite.modulate = Color("black")
			
		_:
			push_error("Tried to set color to a color not declared")

func set_color(color: CharacterColors) -> void:
	if color != character_color:
		print("balls")
		character_color = color
		update_color()
