extends TextureRect

@onready var icon := $ItemIcon #Assign ItemIcon node to var
@onready var count_label := $StackAmount #Assign StackAmount node to count_label

func set_item(item: ItemResource, count: int):
	if item != null:
		icon.texture = item.texture
		icon.modulate = item.color_tint
		count_label.text = "x%d" % count if count > 1 else ""
	else:
		icon.texture = null
		icon.modulate = Color(1, 1, 1) #Reset tint
		count_label.text = ""
