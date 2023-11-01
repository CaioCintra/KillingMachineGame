extends Area2D

func _on_body_entered(body):
	if body.is_in_group("players") and body.name != "Josh":
		body.velocity.y = body.JUMP_VELOCITY
		body.isHurt = true
		$sound_damage.play()
		$GameOver.gameOver()
