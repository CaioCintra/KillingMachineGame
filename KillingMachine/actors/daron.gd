extends CharacterBody2D

const SPEED = 300.0
var JUMP_VELOCITY = -430.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var isHurt := false
var isAttaking := false
var ativo = false
var lookingLeft = false
var climbing = false

@onready var ui_canvas := $"../ui_canvas" as CanvasLayer
@onready var animation := $anim as AnimatedSprite2D

func _physics_process(delta):
	if !climbing:
	# Add the gravity.
		velocity.y += gravity * delta
	elif climbing:
		is_jumping = false
		velocity.y = -(SPEED)
	
	if is_on_floor():
		is_jumping = false
	
	$Indicador.visible = ativo
	
	if ativo:
		$Camera.make_current()
				
		$Indicador.play("default")
		
		var item = $RayCast2D.get_collider()
		var level = get_parent()
		if item != null:
			if (item.name == "PortaChave") and level.temChave :
				item.queue_free()
		# Handle Jump.
		if Input.is_action_just_pressed("ui_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$sound_jump.play()
			is_jumping = true
			
		elif Input.is_action_just_pressed("ui_power"):
			isAttaking = true
			$sound_attack.play()
			if !(get_parent().temAmp) :
				var porta = $RayCast2D.get_collider()
				if porta != null:
						if "PortaVidro" in porta.name:
							$glass.play()
							porta.queue_free()
			else:
				for obj in get_parent().get_children():
					if "PortaVidro" in obj.name:
						$glass.play()
						obj.queue_free()
						
			await get_tree().create_timer(0.8).timeout
			isAttaking = false
	
		# Get the input direction and handle the movement/deceleration.
		var direction = round(Input.get_axis("ui_left", "ui_right"))
		
		if direction != 0:
			if velocity.x >= 0:
				if lookingLeft == true:
					$RayCast2D.rotate(3.1415)
				lookingLeft = false
			else:
				if lookingLeft == false:
					$RayCast2D.rotate(3.1415)	
				lookingLeft = true
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if !is_jumping:
				animation.play("run")
			else:
				animation.play("jump")                    
		elif is_jumping or climbing:
			animation.play("jump")                    
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if !isAttaking:
				animation.play("idle")
			else:
				animation.play("attack")
	else:
		animation.play("idle")
		velocity.x = 0		
			
	if isHurt:
		animation.play("hurt")

	move_and_slide()
