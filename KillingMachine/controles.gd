extends Node

@onready var back = $CanvasLayer/VBoxContainer/back_btn
@onready var menu = $"."

func _ready():
	back.grab_focus()

func _on_back_btn_pressed():
	get_tree().change_scene_to_file("res://levels/Intro.tscn")
	menu.queue_free()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://levels/Intro.tscn")
		menu.queue_free()
