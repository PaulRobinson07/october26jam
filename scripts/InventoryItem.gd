class_name InventoryItem
extends TextureRect

##imported data about the item
@export var data: ItemData
var is_being_dragged = false


##takes in the data about the item and saves it
func init(d: ItemData) -> void:
	data = d
	
func _ready():
	#sets the type of rendering for the item in the inventory
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	
	#tooltip to give information about the item if the user hovers over it
	#TODO make it toggleable in settings
	tooltip_text = "{0}\n{1}".format([data.name, data.description])

##gets the data of the object if it's being dragged by the player
func _get_drag_data(at_position: Vector2):
	set_drag_preview(make_drag_preview(at_position))
	return self
	
##makes a temporary object that follows the cursor
func make_drag_preview(at_position: Vector2):
	#generic stuff to make the item follow the cursor
	var t := TextureRect.new()
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_position)
	
	is_being_dragged = true
	
	#makes it actually follow the cursor
	var c:= Control.new()
	c.add_child(t)
	return c
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and is_being_dragged:
		if not is_drag_successful():
			print("drop item into world instead of inventory")
			queue_free()
