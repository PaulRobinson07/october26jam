extends CanvasLayer

var InventorySize = 16
var SlotSize = 40

var itemsLoad = [
	"res://pixel-video-game-sword-icon-cartoon-retro-style-set-108038150.webp",
	"res://icon.svg"
]

func _ready():
	self.visible = false
	for i in InventorySize:
		var slot := InventorySlot.new(ItemData.Type.MAIN,Vector2(SlotSize,SlotSize))
		%Inventory.add_child(slot)
	for i in itemsLoad.size():
		var item := InventoryItem.new()
		var d = ItemData.new()
		d.texture = load(itemsLoad[i])
		d.description = "smaller balls info"
		d.name = "BALLBALLS"
		item.init(d)
		%Inventory.get_child(i).add_child(item)

func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		self.visible = !self.visible
