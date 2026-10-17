extends RigidBody2D
class_name ItemPhyscial

##maximum angle that the item can be launched at
@export var MAX_ANGLE = PI

##minimum angle that the item can be launched at
@export var MIN_ANGLE = 0

##speed that a item is launched at
@export var LAUNCH_SPEED = -600

##the data about the actual item
var data = ItemData.new()

func _init(d: ItemData, pos: Vector2):
	#inputed data from the spawner
	position = pos
	data = d
	#launches the item randomly on spawn
	#NOTE this can be used to launch the item with force on spawn
	#linear_velocity = Vector2(cos(randf_range(MIN_ANGLE,MAX_ANGLE))*LAUNCH_SPEED,sin(randf_range(MIN_ANGLE,MAX_ANGLE)*LAUNCH_SPEED))
	
	#code to give a sprite to the item
	var sprite = Sprite2D.new()
	sprite.texture = data.texture
	sprite.name = "ItemSprite"
	add_child(sprite)
	var sprite_size = 100
	sprite.scale.x = float(sprite_size)/sprite.texture.get_width()
	sprite.scale.y = float(sprite_size)/sprite.texture.get_height()
	
	#makes and sets up the collision
	var collision = CollisionShape2D.new()
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	add_child(collision)

	#makes and sets up the collision shape
	var circle = CircleShape2D.new()
	circle.radius = 50.0
	collision.shape = circle
	
	#makes the item collision system
	var area2d = ItemCollision.new()
	add_child(area2d)
	
	var label = ItemLabel.new()
	add_child(label)
	label.target_node = self
