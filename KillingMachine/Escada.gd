extends Area2D





func _on_body_entered(body):
	if body.is_in_group("players"):
		if body.climbing == false:
			body.climbing = true


func _on_body_exited(body):
	if body.is_in_group("players"):
		if body.climbing == true:
			body.climbing = false
	pass # Replace with function body.
