extends Area2D

func _ready() -> void:
	#allows us to call _on_body_entered()
	body_entered.connect(_on_body_entered)

##if the item collides with the player then let the player pick the item up
func _on_body_entered(body: Node2D) -> void:
	#makes the item an inventory rather than an physical item
	var item := InventoryItem.new()
	item.init(get_parent().data)
	
	#TODO make the item be added to the first open slot
	%Inventory.get_child(3).add_child(item)
	
	#kills the ground item
	#TODO check if the item can be added to the inventory before killing it
	get_parent().get_parent().queue_free()
