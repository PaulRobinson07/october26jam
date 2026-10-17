extends Area2D
class_name ItemCollision

func _ready() -> void:
	#nodes needed to run
	var pickup_area_collision = CollisionShape2D.new()
	var pickup_radius = CircleShape2D.new()
	add_child(pickup_area_collision)
	
	#setup for nodes
	pickup_radius.radius = 70.0
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
	
	var picked_up = false
	var inventory = get_tree().current_scene.find_child("Inventory", true, false)
	
	#make the item be added to the first open slot
	for i in range(16):
		if inventory.get_child(i).get_child_count() == 0:
			inventory.get_child(i).add_child(item)
			picked_up = true

	#check if the item can be added to the inventory before killing it
	if picked_up:
		#kills the ground item
		get_parent().queue_free()
