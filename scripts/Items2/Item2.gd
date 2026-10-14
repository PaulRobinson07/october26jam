extends Node
class_name Item2
var data = ItemData

func _init(d: ItemData, pos: Vector2):
	var item = Item2Physcial.new(d, pos)
	add_child(item)
