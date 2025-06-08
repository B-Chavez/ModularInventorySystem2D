extends Node
class_name inventory_ui

signal ready_to_populate

@onready var grid = $CanvasLayer/InventoryGrid #Assigns the node only after it's fully ready in the scene
@export var slot_scene: PackedScene #Loadable, instantiatable scene

func _ready():
	print("InventoryUI is ready.")
	
	print("Emitting ready_to_populate signal.")
	ready_to_populate.emit()
	
	for child in get_children():
		print("Child node:", child.name)
	
	print("Grid from _ready():", grid)
	
	print("IN UI _ready() — grid is:", grid)
	
	

func populate_inventory(inventory: Array):
	print("Populating inventory. Slots to add:", inventory.size())
	if grid == null:
		push_error("populate_inventory: grid is null!")
		return
	
	print("Line 20 | Grid: ",grid)
	for child in grid.get_children(): #clear grid
		grid.remove_child(child)
		child.queue_free()

	for slot_data in inventory:
		print("Slot data item:", slot_data.item.name, "Count:", slot_data.count)
		var slot_ui = slot_scene.instantiate() #instantiate a new blank slot_scene and assign it to slot_ui
		grid.add_child(slot_ui) #add the slot_ui to InventoryGrid node as a child
		
		if slot_data.item != null: #if there's no item in slot_data because it's null then run code block
			slot_ui.set_item(slot_data.item, slot_data.count) #set slot_data.item and slot_data.count to slot_ui
