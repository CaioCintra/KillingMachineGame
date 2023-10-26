extends Area2D

const SPEED := 100
var velocity := Vector2.ZERO
var direction :=1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_direction(dir):
	direction = dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta * direction
	translate(velocity)
