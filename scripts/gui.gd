extends CanvasLayer

##the size of the main inventory
@export var InventorySize = 16

##the size of the inventory graphical elements
@export var SlotSize = 40

#temporary variables textures of temporary items
var itemsLoad = [
	"res://pixel-video-game-sword-icon-cartoon-retro-style-set-108038150.webp",
	"res://icon.svg"
]

func _ready():
	#makes the inventory invisible upon first loading the game
	self.visible = false
	
	#for each item in the inventory makes a new slot
	for i in InventorySize:
		#makes a slot
		var slot := InventorySlot.new(ItemData.Type.MAIN,Vector2(SlotSize,SlotSize))
		
		#adds it to the inventory
		%Inventory.add_child(slot)
	
	#example code of how to add a slot of a new type
	var slot := InventorySlot.new(ItemData.Type.BACKPACK,Vector2(SlotSize,SlotSize))
	%Inventory.add_child(slot)
	
	#example code of how to add a item that is generic
	for i in itemsLoad.size():
		var item := InventoryItem.new()
		var d = ItemData.new()
		d.texture = load(itemsLoad[i])
		d.description = "smaller balls info"
		d.name = "BALLBALLS"
		d.type = ItemData.Type.MAIN
		item.init(d)
		%Inventory.get_child(i).add_child(item)
	
	#example code of how to add a item that is specific, in this case a backpack item
	var item := InventoryItem.new()
	var d = ItemData.new()
	d.texture = load(itemsLoad[0])
	d.description = "smaller balls info"
	d.name = "BALLBALLS"
	d.type = ItemData.Type.BACKPACK
	item.init(d)
	%Inventory.get_child(16).add_child(item)

func _process(delta):
	#if the user asked the game to open or close the inventory do so
	if Input.is_action_just_pressed("Inventory"):
		self.visible = !self.visible
