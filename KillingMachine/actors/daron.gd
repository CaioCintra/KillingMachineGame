extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -430.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var isHurt := false
var isAttaking := false
var ativo = false

@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

func _physics_process(delta):

	# Add the gravity.
	velocity.y += gravity * delta
	
	if is_on_floor():
		is_jumping = false
	
	$Indicador.visible = ativo
	
	if ativo:
		$Camera.make_current()
				
		$Indicador.play("default")
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$sound_jump.play()
			is_jumping = true
			
		elif Input.is_action_just_pressed("power"):
			isAttaking = true
			$sound_attack.play()
			var porta = $RayCast2D.get_collider()
			if porta != null:
				if (porta.name == "PortaVidro") :
					porta.queue_free()
			await get_tree().create_timer(0.8).timeout
			isAttaking = false
	
		# Get the input direction and handle the movement/deceleration.
		var direction = round(Input.get_axis("ui_left", "ui_right"))
		
		if direction != 0:
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if !is_jumping:
				animation.play("run")
			else:
				animation.play("jump")                    
		elif is_jumping:
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
