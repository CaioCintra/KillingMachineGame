extends Node

@onready var start = $CanvasLayer/VBoxContainer/Start
@onready var menu = $"."

func _ready():
	start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	menu.queue_free()

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://controles.tscn")
	menu.queue_free()
	



func _on_quit_pressed():
	get_tree().quit()


func _on_start_touch_pressed():
	get_tree().change_scene_to_file("res://levels/world_01.tscn")
	menu.queue_free()


func _on_controls_touch_pressed():
	get_tree().change_scene_to_file("res://controles.tscn")
	menu.queue_free()
	


func _on_quit_touch_pressed():
	get_tree().quit()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://creditos.tscn")
	menu.queue_free()


func _on_credits_touch_pressed():
	get_tree().change_scene_to_file("res://creditos.tscn")
	menu.queue_free()
