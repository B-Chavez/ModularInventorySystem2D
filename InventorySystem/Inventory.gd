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
	for slot in inventoryContainer.size():
		print(inventoryContainer[slot])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item: Resource) -> bool: # -> bool means you're going to return a boolean
	if is_full(): #If is_full returns true, which means the inventory is full, then return false to whatever called add_item
		return false
	
	#Check if the item exists and is stackable
	for slot in inventoryContainer:

		if slot["item"].id == item.id and slot["item"].stackable:
			slot["item"].count += 1
			return true
	
	#Otherwise, place in a new slot
	inventoryContainer.append(
		{"item": item, "count":1}
	)
	print("Line 39 ", inventoryContainer)
	return true	
	
# Remove item that has been passed in when function was called from inventoryContainer array
func remove_item(item: Resource) -> bool:
	if inventoryContainer.has(item): #if inventoryContainer array has the item passed in when function was called
		inventoryContainer.erase(item) #erase item passed in when function was called from inventoryContainer array
		return true
	return false
	
func is_full() -> bool:
	return inventoryContainer.size() >= inventoryMaxSize #Apparently you can use an if statement on the return line and return if it's true or not.
	# So if the inventory is full or over the MaxSize then return true to whatever called add_item
