extends Resource
class_name ItemResource

@export var id: int
@export var name: String
@export var texture: Texture2D
@export var stackable: bool = false
@export var max_stack: int = 1
@export var rarity: String = "common"
@export var description: String = ""
@export var metadata: Dictionary = {}
@export var color_tint: Color = Color(1, 1, 1)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
