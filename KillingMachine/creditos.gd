extends Node

@onready var menu = $"."
@onready var back = $CanvasLayer/menu
@onready var scroll = $CanvasLayer/ScrollContainer

var scroll_speed = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	back.grab_focus()
	$CanvasLayer/ScrollContainer.scroll_vertical += scroll_speed
	

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Intro.tscn")
	menu.queue_free()


func _on_touch_back_pressed():
	get_tree().change_scene_to_file("res://Intro.tscn")
	menu.queue_free()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Intro.tscn")
		menu.queue_free()

func _process(delta):
	$CanvasLayer/ScrollContainer.scroll_vertical += scroll_speed * delta
