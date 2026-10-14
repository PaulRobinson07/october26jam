extends Area2D
class_name ItemCollision

func _ready() -> void:
	var pickup_area_collision = CollisionShape2D.new()
	var pickup_radius = CircleShape2D.new()
	add_child(pickup_area_collision)
	pickup_radius.radius = 20.0
	pickup_area_collision.shape = pickup_radius
	set_collision_mask_value(4, true)
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	#allows us to call _on_body_entered()
	body_entered.connect(_on_body_entered)

##if the item collides with the player then let the player pick the item up
func _on_body_entered(body: Node2D) -> void:
	if (body==get_parent()):
		return
	#makes the item an inventory rather than an physical item
	var item := InventoryItem.new()
	item.init(get_parent().data)
	
	#TODO make the item be added to the first open slot
	get_tree().current_scene.find_child("Inventory",true,false).get_child(3).add_child(item)

	#kills the ground item
	#TODO check if the item can be added to the inventory before killing it
	get_parent().get_parent().queue_free()
