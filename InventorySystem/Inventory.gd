extends Node
class_name InventoryMaster

var inventoryContainer: Array = [] #Stores each item in here
@export var inventoryMaxSize: int = 1 #Inventory maximum size, note this is not a constant, so if you wanna change it go ahead. It might break the UI though if you go to high

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item(item: Resource) -> bool: # -> bool means you're going to return a boolean
	if is_full(): #If is_full returns true, which means the inventory is full, then return false to whatever called add_item
		return false
	#Otherwise add the item, which is a Resource, to the inventoryContainer and return true to whatever called add_item
	inventoryContainer.append(item)
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
