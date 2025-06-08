extends Node
signal item_added(item: ItemResource, count: int)

@export var max_slots: int = 16
var items: Dictionary = {} # key: ItemResource, value: count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Main scene is ready")
	print("Children:")
	for child in get_children():
		print(" - ", child.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item: ItemResource) -> void:
	if items.has(item):
		items[item] += 1
	else:
		if items.size() >= max_slots:
			push_warning("Inventory full!")
			return
		items[item] = 1
	emit_signal("item_added", item, items[item])
	
