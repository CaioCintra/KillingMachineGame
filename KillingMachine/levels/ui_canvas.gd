extends CanvasLayer


func add_item_inventory(sprite: Texture) -> bool:
	var children = $Inventory/container.get_children()
	if children:
		for i in range(children.size() - 1, -1, -1):
			var slot = children[i]
			var slot_sprite = slot.get_node("sprite")
			if slot_sprite.texture == null:
				slot_sprite.texture = sprite
				return true
	return false

			
