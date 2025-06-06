extends CanvasLayer
class_name inventory_ui

@onready var grid = $CanvasLayer/InventoryGrid #Assigns the node only after it's fully ready in the scene
@export var slot_scene: PackedScene #Loadable, instantiatable scene

func populate_inventory(inventory: Array):
	print("Grid: ",grid)
	for child in grid.get_children(): #clear grid
		grid.remove_child(child)
		child.queue_free()

	for slot_data in inventory:
		var slot_ui = slot_scene.instantiate() #instantiate a new blank slot_scene and assign it to slot_ui
		grid.add_child(slot_ui) #add the slot_ui to InventoryGrid node as a child
		
		if slot_data.item != null: #if there's no item in slot_data because it's null then run code block
			slot_ui.set_item(slot_data.item, slot_data.count) #set slot_data.item and slot_data.count to slot_ui
