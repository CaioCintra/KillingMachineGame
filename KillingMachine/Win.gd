extends CanvasLayer

@onready var next_btn = $menu_win/next_btn

func _ready():
	visible = false

func Win():
	visible = true
	get_tree().paused = true
	$som.play()
	next_btn.grab_focus()

func _on_next_btn_pressed():
	pass # Replace with function body.



func _on_quit_btn_pressed():
	get_tree().queue_free()
	get_tree().change_scene_to_file("res://Intro.tscn")



func _on_touch_next_pressed():
	pass # Replace with function body.


func _on_touch_quit_pressed():
	get_tree().change_scene_to_file("res://Intro.tscn")
