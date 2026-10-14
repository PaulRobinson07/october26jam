class_name InventorySlot
extends PanelContainer

##imput data for the item
@export var type: ItemData.Type

##takes in the type of the slot and the size of the slot
func _init(t: ItemData.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms

##determines if the item can be dropped onto this inventory slot
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		#if the datatype is generic
		if type == ItemData.Type.MAIN:
			#if there are no other items return true
			if get_child_count() == 0:
				return true
			else:
				#if the item is full but the types are the same just replace them
				if type == data.get_parent().type:
					return true
			#another check if the data can be switched
			return get_child(0).data.type == data.data.type
		else:
			#another check if the data can be switched
			return data.data.type == type
	#if every check fails return false
	return false

##switches two item's inventory slot or simply makes one go to a new one
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	#if there is already an item there switch them
	if get_child_count() > 0:
		#switches the old item to the location of the new one
		var item := get_child(0)
		#if the items are the same exact item, do nothing because it's the same thing as changing them
		#NOTE this is where the code would go for making stacking items of the same type possible
		#TODO do the above statement in a later version
		if item == data:
			return
		#changes the original item's location
		item.reparent(data.get_parent())
	#switches the old item to go to a new inventory slot
	data.reparent(self)
