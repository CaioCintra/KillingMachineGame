extends Area2D





func _on_body_entered(body):
	if body.ui_canvas.add_item_inventory($Sprite2D.texture):
		$"../Vic".JUMP_VELOCITY -= 350
		$"../Daron".JUMP_VELOCITY -= 350
		$"../Josh".JUMP_VELOCITY -= 350
		queue_free()
