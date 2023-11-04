extends Area2D


func _on_body_entered(body):
	if body.is_in_group("players"):
		get_parent().jogadoresFinalizados += 1
		print(get_parent().jogadoresFinalizados)
		


func _on_body_exited(body):
	if body.is_in_group("players"):
		get_parent().jogadoresFinalizados -= 1
