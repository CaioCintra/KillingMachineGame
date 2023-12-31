extends CanvasLayer

@onready var reset_btn = $menu_gameOver/reset_btn

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func gameOver():
	visible = true
	get_tree().paused = true
	$som.play()
	reset_btn.grab_focus()

func _on_reset_btn_pressed():
	visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()



func _on_quit_btn_pressed():
	get_tree().change_scene_to_file("res://Intro.tscn")
	get_tree().paused = false


func _on_touch_reset_pressed():
	visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _on_touch_quit_pressed():
	get_tree().change_scene_to_file("res://Intro.tscn")
	get_tree().paused = false
