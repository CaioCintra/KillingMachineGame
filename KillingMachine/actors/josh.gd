extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -430.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var ativo = false

@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

func _physics_process(delta):

	# Add the gravity.
	velocity.y += gravity * delta
	
	if is_on_floor():
		is_jumping = false
	
	if ativo:
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumping = true
	
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
			animation.play("idle")
	else:
		animation.play("idle")		
		velocity.x = 0
		
	move_and_slide()
