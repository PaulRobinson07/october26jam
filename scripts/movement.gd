extends CharacterBody2D
@export var SPEED = 0;
@export var JUMP_VELOCITY = -1000;
@onready var SPRITE = $AnimatedSprite2D

@export var ACCELERATION = 10
@export var MAX_SPEED = 400
enum STATE {IDLING,WALKING,JUMPING,FALLING}
var current_state = STATE.IDLING
var MINIMUM_GRAVITY = 2
var MAXIMUM_GRAVITY = 3
var gravity = MINIMUM_GRAVITY
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity +=get_gravity() * delta * gravity
		if Input.is_action_just_released("Jump") or current_state == STATE.FALLING:
			gravity=MAXIMUM_GRAVITY
		if (velocity.y<0):
			current_state = STATE.JUMPING
		else:
			current_state = STATE.FALLING
	else:
		gravity = MINIMUM_GRAVITY
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y=JUMP_VELOCITY
	var direction:= Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction*move_toward(abs(velocity.x),MAX_SPEED,ACCELERATION)
		if is_on_floor():
			current_state = STATE.WALKING
		if (direction==1):
			SPRITE.flip_h = true
		else:
			SPRITE.flip_h = false
	else:
		velocity.x = move_toward(velocity.x,0,ACCELERATION*4)
		if is_on_floor():
			current_state = STATE.IDLING
	pick_animation()
	move_and_slide()

func pick_animation():
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
