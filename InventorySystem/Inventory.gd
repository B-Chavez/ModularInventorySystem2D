extends Node
class_name InventoryMaster

@export var inventory_ui: Node #Set in inspector

var inventoryContainer: Array = [] #Stores each item in here
@export var inventoryMaxSize: int = 10 #Inventory maximum size, note this is not a constant, so if you wanna change it go ahead. It might break the UI though if you go to high

var tempItem = preload("res://items/soda_can.tres")
var tempItem2 = preload("res://items/soda_can2.tres")
var tempItem3 = preload("res://items/soda_can3.tres")
var tempItem4 = preload("res://items/soda_can_cherry.tres")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame #Let the scene tree finish building
	
	
	if inventory_ui == null:
		push_error("inventory_ui is null!")
		return
	
	print("Inventory.gd ready() has started")
	print("inventory_ui =", inventory_ui)
	
	if not inventory_ui.has_signal("ready_to_populate"):
		push_error("inventory_ui has no ready_to_populate signal!")
		return
	
	inventory_ui.ready_to_populate.connect(Callable(self, "_on_inventory_ui_ready"))
	print("Manually calling _on_inventory_ui_ready() for debug...")
	_on_inventory_ui_ready()
	print("Signal list on inventory_ui: ", inventory_ui.get_signal_list())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item: Resource) -> bool: # -> bool means you're going to return a boolean
	if is_full() && is_stackable(item) != true: #If is_full returns true, which means the inventory is full, then return false to whatever called add_item and if is_stackable() is false, which means you can't stack any more in any of the slots with the item it then inventory is full
		print("Line 42 | Inventory is full.")
		return false
	
	
	#Check if the item exists and is stackable
	for slot in inventoryContainer:
		if slot.item.id == item.id and slot.item.stackable and slot.count <  item.max_stack: #This compares id's, check to see if the bool is true for the attribute stackable, and finally is stopped if max_stack is met
			slot.count += 1 #Adds item to stack in current slot 
			print("Line 50 | ID:", slot.item.id, "| Name:", slot.item.name, "| Count:", slot.count)
			return true
			
	
	
	#if there's nothing in the array or it's under the inventoryMaxSize then append a new instance of InventorySlot
	if inventoryContainer.size() < inventoryMaxSize:
		var new_slot = InventorySlot.new()
		new_slot.item = item
		new_slot.count = 1
		inventoryContainer.append(new_slot)
		return true
	
	#Find the InventorySlot that was just appended above here and change the default count to 1
	for slot in inventoryContainer:
		if slot.item == null:
			slot.item = item
			slot.count = 1
			return true
	
	for slotNumber in inventoryContainer.size():
		print("Line 69 | Slot ", slotNumber + 1, ": ", inventoryContainer[slotNumber].item.name, " Quantity in this slot: ", inventoryContainer[slotNumber].count)
	return true	
	
# Remove item that has been passed in when function was called from inventoryContainer array
func remove_item(slotNumber, removeFromStackAmount):
	if slotNumber >= inventoryContainer.size(): #If your slot number is out of range of the amount of locations in the inventoryContainer array then return false
		print("Line 75 | Invalid slot number")
		return false
	
	var slot = inventoryContainer[slotNumber] # Assign the array location that was chosen from the inventoryContainer to slot
	
	#if the slot that was chosen doesn't exist because it's null then return false
	if slot.item == null:
		print("Line 82 | Slot is already empty")
		return false
	
	#if the slot count is less than or equal to the amount you want to remove then reset item and count to defaults
	if slot.count <= removeFromStackAmount:
		slot.item = null
		slot.count = 0
	else: #otherwise slot.count is more than the amount wanting to be removed so subtract the amount to be removed from the slot.count amount e.g. 3(slot.count) - 2(removeFromStackAmount) = 1(slot.count)
		slot.count = slot.count - removeFromStackAmount
	
	return true
	
func is_full() -> bool:
	return inventoryContainer.size() >= inventoryMaxSize #Apparently you can use an if statement on the return line and return if it's true or not.
	# So if the inventory is full or over the MaxSize then return true to whatever called add_item because this is a check at the beginning of the function

func is_stackable(item: Resource) -> bool:
	for slot in inventoryContainer: #iterate through the inventory array and assign a location to slot
		if item.max_stack > slot.count && item == slot.item: #if the max_stack in the resource for the item is more than how much you have currently stacked on that item and item == slot.item return true, this ensures that the item being place into the invetory will be checked to ensure the stack doesn't go over item.max_stack and stacked as long as it's the same item
			return true #return true, meaning you can place another item in the stack
		elif slot.item == null: #if slot.item == null then you can place an item here
			return true
		elif slot.item.stackable: #if the variable, stackable, that's in the resource item is true return true
			return true
	return false #return false if the item you're placing in the inventory cannot be stacked because the max_stack has been met or was exceeded
	
func _on_inventory_ui_ready() -> void:
		print("_on_inventory_ui_ready started")
		add_test_items()
		print("inventory_ui has populate_inventory()?", inventory_ui.has_method("populate_inventory"))
		
		print("Calling inventory_ui.populate_inventory(inventoryContainer)")
		inventory_ui.populate_inventory(inventoryContainer)


func add_test_items():
	var test_items = [
		tempItem,        # 1st item type
		tempItem2,       # 2nd item type
		tempItem,
		tempItem2,
		tempItem,
		tempItem3,
		tempItem2,
		tempItem,
		tempItem2,
		tempItem
	]
	
	for i in 10:
		for item in test_items:
			add_item(item)
		
	inventory_ui.populate_inventory(inventoryContainer)
