extends CharacterBody2D

const SHOT := preload("res://enemies/shot.tscn")

var timer : float = 0

func _process(delta: float) -> void:
	# Incrementa o temporizador com o tempo desde o último quadro
	timer += delta
	
	if timer >= 1.0:
		# Chama a função que você quer executar a cada segundo
		_on_timer_timeout()
		
		# Reinicia o temporizador
		timer = 0

func _on_timer_timeout() -> void:
	var shot_instance =  SHOT.instantiate()
	get_parent().add_child(shot_instance)
	shot_instance.position = $Tiro.global_position



