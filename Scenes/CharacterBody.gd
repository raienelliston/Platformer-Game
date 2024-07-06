extends CharacterBody2D

@export var speed = 400
@export var gravity = 20
@export var jump_power = -3000

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
