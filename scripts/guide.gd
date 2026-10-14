extends CharacterBody2D

func _physics_process(delta: float) -> void:
	#if the npc is not on the floor, make it fall
	if not is_on_floor():
		velocity +=get_gravity() * delta
		
	#update movement
	move_and_slide()
