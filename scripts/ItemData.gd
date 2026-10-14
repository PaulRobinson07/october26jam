class_name ItemData
extends Resource

##data about where the item can be stored in the inventory
enum Type {
	##generic types, can be placed anywhere non-specefic
	MAIN, 
	##testing type for types that can go in a specefic slot
	BACKPACK
}

##The type given to the item
@export var type: Type

##the name of the item
@export var name: String

##the description of the item
@export_multiline var description: String

##the texture to load in the gui
@export var texture: Texture2D
