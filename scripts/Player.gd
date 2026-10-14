extends CharacterBody2D
class_name Player

#TODO: make all movement variables less abritary for better movement feel

##walk speed of the player
@export var SPEED = 0;

##jump launch velocity of the player
@export var JUMP_VELOCITY = -1000;

##walking acceleration
@export var ACCELERATION = 10

##maximum walk speed that the player is accelerating to
@export var MAX_SPEED = 400

##spite object to pull textures from
@onready var SPRITE = $AnimatedSprite2D

#basic variables determining how gravity functions
@export var MINIMUM_GRAVITY = 2
@export var MAXIMUM_GRAVITY = 3
@export var gravity = MINIMUM_GRAVITY

##enum storing all possible states that the player can be in
enum STATE {IDLING,WALKING,JUMPING,FALLING,INTERACTING}

##stores the current state that the player is in
var current_state = STATE.IDLING

func _physics_process(delta: float) -> void:
	#if the player is currently in the air
	if not is_on_floor():
		#makes them fall faster and faster
		#TODO make a terminal velocity
		velocity +=get_gravity() * delta * gravity
		
		#if the player released the jump button or is at the apex of their jump
		if Input.is_action_just_released("Jump") or current_state == STATE.FALLING:
			#make the gravity factor the maximum gravity
			gravity=MAXIMUM_GRAVITY
		
		#properly determines the current state of the player while in air
		if (velocity.y<0):
			current_state = STATE.JUMPING
		else:
			current_state = STATE.FALLING
	#if the player is on the ground, reset gravity
	else:
		gravity = MINIMUM_GRAVITY
	
	#causes the player to jump if they can
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y=JUMP_VELOCITY
		
	#determines which direction the player wants the player to move in
	var direction:= Input.get_axis("Left", "Right")
	
	#if the player wants the player to move, accelerate the player in that direction
	#TODO make the player deccelerate before switching movement to the opposite direction for consistency
	if direction:
		#make the player accelerate, but only to a reasonable amount
		velocity.x = direction*move_toward(abs(velocity.x),MAX_SPEED,ACCELERATION)
		
		#if the player is on the floor change the state
		#NOTE do not remove the if statement because otherwise the player will "walk" on air
		if is_on_floor():
			current_state = STATE.WALKING
			
		#sets the correct movement direction
		if (direction==1):
			SPRITE.flip_h = true
		else:
			SPRITE.flip_h = false

	#if the player is not actively trying to move left or right
	else:
		#decclerate the player faster than they accelerated
		#TODO change to a less abritary value
		velocity.x = move_toward(velocity.x,0,ACCELERATION*4)

		#set the proper state
		if is_on_floor():
			#TODO change to allow for the player to skid/slow down with (if abs(velocity>0))
			current_state = STATE.IDLING
	
	#moves and animates the player
	pick_animation()
	move_and_slide()

##[b]picks the current animation of the player.[/b] [br]
##does not reset the last animation's frame to 0
func pick_animation():
	#runs to determine if the current sprite needs to be changed, if so it does
	match(current_state):
		STATE.IDLING:
			SPRITE.play("idling")
		STATE.WALKING:
			SPRITE.play("walking")
		STATE.JUMPING:
			SPRITE.play("jumping")
		STATE.FALLING:
			SPRITE.play("falling")
		_:
			SPRITE.play("idling")
