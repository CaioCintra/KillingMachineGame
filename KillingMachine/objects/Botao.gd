extends Area2D





func _on_body_entered(_body):
		$"..".queue_free()
		$AudioStreamPlayer2D.play
		queue_free()
