extends Label
class_name ItemLabel

##the name of the item
@export var item_name  = "Placeholder Name "

##the number of said item must be greater than one
@export var item_count = 1;

##the target that our text lies above
@export var target_node: Node2D 

func _ready():
	#sets alignment of the text
	horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VerticalAlignment.VERTICAL_ALIGNMENT_CENTER
	
func _process(delta):
	#updates the text if needed (if there's an item count change)
	text = item_name + " " + str(item_count) + "X"

	#sets the position to be right above the item
	var target_pos = target_node.global_position
	global_position = Vector2(target_pos.x- (size.x / 2.0), target_pos.y - 80)
