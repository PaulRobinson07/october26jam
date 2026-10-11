extends CharacterBody2D
@export var SPEED = 320;
@export var JUMP_VELOCITY = -500;

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity +=get_gravity() * delta
	move_and_slide()
