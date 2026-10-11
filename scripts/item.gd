extends RigidBody2D

#initial condition parameters
@export var MAX_ANGLE = PI
@export var MIN_ANGLE = 0
@export var LAUNCH_SPEED = -300


func _ready():
	position = Vector2(50,-200)
	#launches the item randomly on spawn
	linear_velocity = Vector2(cos(randf_range(MIN_ANGLE,MAX_ANGLE))*LAUNCH_SPEED,sin(randf_range(MIN_ANGLE,MAX_ANGLE)*LAUNCH_SPEED))
