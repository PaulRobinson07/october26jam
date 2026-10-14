extends RigidBody2D
class_name Item2Physcial

##maximum angle that the item can be launched at
@export var MAX_ANGLE = PI

##minimum angle that the item can be launched at
@export var MIN_ANGLE = 0

##speed that a item is launched at
@export var LAUNCH_SPEED = -600

##the data about the actual item
var data = ItemData.new()

func _init(d: ItemData, pos: Vector2):
	position = pos
	data = d
	#launches the item randomly on spawn
	#NOTE this is temporary code that outlines a basic item if somehting else wasn't given
	#linear_velocity = Vector2(cos(randf_range(MIN_ANGLE,MAX_ANGLE))*LAUNCH_SPEED,sin(randf_range(MIN_ANGLE,MAX_ANGLE)*LAUNCH_SPEED))
	var sprite = Sprite2D.new()
	sprite.texture = data.texture
	sprite.name = "ItemSprite"
	add_child(sprite)
	var collision = CollisionShape2D.new()
	
	
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	add_child(collision)

	var circle = CircleShape2D.new()

	circle.radius = 10.0
	collision.shape = circle
	
	var area2d = ItemCollision.new()
	add_child(area2d)
