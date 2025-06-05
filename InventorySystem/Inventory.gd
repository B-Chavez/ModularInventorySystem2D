extends Node
class_name InventoryMaster

var inventoryContainer: Array = [] #Stores each item in here
@export var inventoryMaxSize: int = 10 #Inventory maximum size, note this is not a constant, so if you wanna change it go ahead. It might break the UI though if you go to high

var tempItem = preload("res://items/soda_can.tres")
var tempItem2 = preload("res://items/soda_can2.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_item(tempItem)
	add_item(tempItem2)
	add_item(tempItem)
	for slot in inventoryContainer.size():
		print(inventoryContainer[slot])
	
	for i in 50:
		add_item(tempItem)
	pass # Replace with function body.

	remove_item(tempItem, 3, 3) #passing in three arguements so we can remove the specific item, determine the location you're trying to remove the item from, and how many you want to remove
	print("Amount of filled slots in inventory: ", inventoryContainer.size())
	for slot in inventoryContainer.size():
		print("Slot ", slot, " ",inventoryContainer[slot]["item"], " Quantity in this slot: ", inventoryContainer[slot]["count"])
	print(inventoryContainer[3])	
	
	add_item(tempItem)
	print(inventoryContainer[3])
	
	add_item(tempItem2)
	for slot in inventoryContainer.size():
		print("Slot ", slot, " ",inventoryContainer[slot]["item"].name, " Quantity in this slot: ", inventoryContainer[slot]["count"])
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item: Resource) -> bool: # -> bool means you're going to return a boolean
	if is_full() && is_stackable(item) != true: #If is_full returns true, which means the inventory is full, then return false to whatever called add_item and if is_stackable() is false, which means you can't stack any more in any of the slots with the item it then inventory is full
		print("Inventory is full.")
		return false
	
	for slot in inventoryContainer:
		if slot["item"] == null:
			slot["item"] = item
			slot["count"] = 1
			return true
	
	#Check if the item exists and is stackable
	for slot in inventoryContainer:

		if slot["item"].id == item.id and slot["item"].stackable and slot["count"] <  item.max_stack: #This compares id's, check to see if the bool is true for the attribute stackable, and finally is stopped if max_stack is met
			slot["count"] += 1 #Adds item to stack in current slot 
			print("Line 39 | ID:", slot["item"].id, "| Name:", slot["item"].name, "| Count:", slot["count"])
			return true
			
	
	
	#Otherwise, place in a new slot
	inventoryContainer.append(
		{"item": item, "count":1}
	)
	for slotNumber in inventoryContainer.size():
		print("Slot ", slotNumber + 1, ": ", inventoryContainer[slotNumber]["item"].name, " Quantity in this slot: ", inventoryContainer[slotNumber]["count"])
	return true	
	
# Remove item that has been passed in when function was called from inventoryContainer array
func remove_item(item: Resource, slotNumber, removeFromStackAmount):
	if slotNumber >= inventoryContainer.size(): #If your slot number is out of range of the amount of locations in the inventoryContainer array then return false
		print("Invalid slot number")
		return false
	
	var slot = inventoryContainer[slotNumber]
	
	if slot["item"] == null:
		print("Slot is already empty")
		return false
	
	if slot["count"] <= removeFromStackAmount:
		slot["item"] = null
		slot["count"] = 0
	else:
		slot["count"] = slot["count"] - removeFromStackAmount
	
	return true
	
func is_full() -> bool:
	return inventoryContainer.size() >= inventoryMaxSize #Apparently you can use an if statement on the return line and return if it's true or not.
	# So if the inventory is full or over the MaxSize then return true to whatever called add_item

func is_stackable(item: Resource) -> bool:
	for slot in inventoryContainer: #iterate through the inventory array
		if item.max_stack > slot["count"] && item == slot["item"]: #if the max_stack in the resource for the item is more than how much you have currently stacked on that item. Also for item == slot["item"] this ensures that the item being place into the invetory will be stacked as long as it's the same item
			return true #return true, meaning you can place another item in the stack
		elif slot["item"] == null:
			return true
	return false #return false if the item you're placing in the inventory cannot be stacked because the max_stack has been met or was exceeded
