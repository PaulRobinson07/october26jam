extends CharacterBody2D
@export var SPEED = 320;
@export var JUMP_VELOCITY = -500;
@onready var SPRITE = $AnimatedSprite2D
enum STATE {IDLING,WALKING,JUMPING,FALLING}
var current_state = STATE.IDLING

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity +=get_gravity() * delta
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y=JUMP_VELOCITY
	var direction:= Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction*SPEED
		current_state = STATE.WALKING
		if (direction==1):
			SPRITE.flip_h = true
		else:
			SPRITE.flip_h = false
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		current_state = STATE.IDLING
	pick_animation()
	move_and_slide()

func pick_animation():
	match(current_state):
		STATE.IDLING:
			SPRITE.play("idling")
		STATE.WALKING:
			SPRITE.play("walking")
