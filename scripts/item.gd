extends RigidBody2D
class_name Item

##maximum angle that the item can be launched at
@export var MAX_ANGLE = PI

##minimum angle that the item can be launched at
@export var MIN_ANGLE = 0

##speed that a item is launched at
@export var LAUNCH_SPEED = -600

##the data about the actual item
var data = ItemData.new()

func _ready():
	position = Vector2(50,-200)
	#launches the item randomly on spawn
	#NOTE this is temporary code that outlines a basic item if somehting else wasn't given
	linear_velocity = Vector2(cos(randf_range(MIN_ANGLE,MAX_ANGLE))*LAUNCH_SPEED,sin(randf_range(MIN_ANGLE,MAX_ANGLE)*LAUNCH_SPEED))
	data.name = "placeholder name"
	data.description = "placeholder description to change later"
	data.type = ItemData.Type.MAIN
	data.texture = load("res://icon.svg")
