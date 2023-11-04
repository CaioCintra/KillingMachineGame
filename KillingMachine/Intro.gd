extends Node2D





func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/world_01.tscn")


func _on_controls_pressed():
	pass # Replace with function body.



func _on_quit_pressed():
	get_tree().quit()


func _on_start_touch_pressed():
	pass # Replace with function body.


func _on_controls_touch_pressed():
	pass # Replace with function body.


func _on_quit_touch_pressed():
	get_tree().quit()
