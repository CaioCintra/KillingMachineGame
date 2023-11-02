extends Area2D





func _on_body_entered(body):
	if body.ui_canvas.add_item_inventory($Sprite2D.texture):
		get_parent().temChave = true
		queue_free()
