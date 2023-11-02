extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -430.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
var _double_jump: bool = false
var isHurt := false
var ativo = false
var lookingLeft = false

var climbing = false

@onready var ui_canvas := $"../ui_canvas" as CanvasLayer
@onready var animation := $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

func _physics_process(delta):
	if !climbing:
	# Add the gravity.
		velocity.y += gravity * delta
	elif climbing:
		is_jumping = false
		velocity.y = -(SPEED)
	
	if is_on_floor():
		is_jumping = false
		_double_jump = false
	
	$Indicador.visible = ativo
	
	if ativo:
		$Camera.make_current()
		$Indicador.play("default")
		
		var item = $abre_porta.get_collider()
		var level = get_parent()
		if item != null:
			if (item.name == "PortaChave") and level.temChave :
				item.queue_free()
		
		# Handle Jump.
		if (Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("power")) and (is_on_floor() or not _double_jump):
			velocity.y = JUMP_VELOCITY
			$sound_jump.play()
			is_jumping = true
			if not is_on_floor():
				velocity.y = JUMP_VELOCITY - 100
				_double_jump = true
				
		# Get the input direction and handle the movement/deceleration.
		var direction = round(Input.get_axis("ui_left", "ui_right"))
		
		if direction != 0:
			if velocity.x >= 0:
				if lookingLeft == true:
					$abre_porta.rotate(3.1415)
				lookingLeft = false
			else:
				if lookingLeft == false:
					$abre_porta.rotate(3.1415)	
				lookingLeft = true
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if !is_jumping:
				animation.play("run")
			else:
				if !_double_jump:
					animation.play("jump")
				else:
					animation.play("doublejump")                     
		elif is_jumping:
			if !_double_jump:
				animation.play("jump")
			else:
				animation.play("doublejump")                    
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animation.play("idle")
	else:
		animation.play("idle")
		velocity.x = 0	
			
	if isHurt:
		animation.play("hurt")

	move_and_slide()
