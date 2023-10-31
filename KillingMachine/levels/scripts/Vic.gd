extends CharacterBody2D

var SPEED = 300.0
const JUMP_VELOCITY = -430.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var isHurt := false
var isDucking := false
var isRunning := false
var blockAbove := false
var ativo = false



@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

func _physics_process(delta):

	# Add the gravity.
	velocity.y += gravity * delta
	
	if is_on_floor():
		is_jumping = false
	
	if ativo:
		$Camera.make_current()
		$Indicador.visible = true
		await get_tree().create_timer(1).timeout
		$Indicador.visible = false
		
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			isDucking = false
			velocity.y = JUMP_VELOCITY
			$sound_jump.play()
			is_jumping = true
	
		if Input.is_action_just_pressed("power") and is_on_floor() and !blockAbove:
			isDucking = !isDucking
	
		# Get the input direction and handle the movement/deceleration.
		var direction = round(Input.get_axis("ui_left", "ui_right"))
		
		if direction != 0:
			isRunning = true
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if !is_jumping:
				if !isDucking:
					animation.play("run")
				else:
					animation.play("duck-run")
			else:
				animation.play("jump")                    
		elif is_jumping:
			animation.play("jump")                    
		else:
			isRunning = false
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animation.play("idle")
	else:
		isRunning = false		
		animation.play("idle")
		velocity.x = 0		
			
	if isHurt:
		animation.play("hurt")
		
	if isDucking and !isRunning:
		animation.play("duck")
		
		
	if !isDucking:
		SPEED = 300.0
		$CollisionShape2D.disabled = false
		$hurtbox/CollisionHurt.disabled = false
		$hurtbox/CollisionDuckHit.disabled = true
	else:
		SPEED = 100.0
		$CollisionShape2D.disabled = true
		$hurtbox/CollisionHurt.disabled = true
		$hurtbox/CollisionDuckHit.disabled = false
		
	if $RayCast2D.get_collider():
		blockAbove = true
	else:
		blockAbove = false

	move_and_slide()
