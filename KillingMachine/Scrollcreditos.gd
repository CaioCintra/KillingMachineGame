extends ScrollContainer

#Call from a parent node the function Scroll_To_Bottom(), it will cycle infinitely.



var TIMER = Timer.new()
var SCROLL = 0

var DELAY = 2.0 #in seconds
var SPEED = 1

func _ready():
	connect("Scroll_Reached_End",self,"Scroll_Restart")
	connect("Scroll_Reached_Top",self,"Scroll_To_Bottom")
	
	TIMER.autostart = 0
	TIMER.one_shot = 1
	TIMER.wait_time = DELAY
	add_child(TIMER)

func _process(delta):
	#Will only work if timer isn't active or simply the time_left == 0.
	if !TIMER.time_left:
		#SCROLL DOWN
		if SCROLL == 1:
			if (scroll_vertical + get_v_scrollbar().page) < get_v_scrollbar().max_value:
				scroll_vertical += SPEED
			else:
				SCROLL = 0
				emit_signal("Scroll_Reached_End")
		
		#SCROLL UP
		elif SCROLL == -1:
			if scroll_vertical != 0:
				scroll_vertical -= SPEED
			else:
				SCROLL = 0
				emit_signal("Scroll_Reached_Top")

func Scroll_Back_Up():
	TIMER.start(DELAY)
	SCROLL = -1

func Scroll_Restart():
	TIMER.start(DELAY*1.5) #Here delay is longer.
	SCROLL = -1 #Loop back up.

func Scroll_To_Bottom():
	scroll_vertical = 0 #Reset to top first.
	TIMER.start(DELAY)
	SCROLL = 1
