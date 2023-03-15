extends CharacterBody2D

const GRAVITY = 400.0
const JUMP_FORCE = 400.0
const FORWARD_VELOCITY = 100.0
const DRAG = 1

signal on_jump

var can_jump = true

func _process(delta):
	velocity.y += delta * GRAVITY
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_jump:
		velocity.y -= JUMP_FORCE
		on_jump.emit()
	if is_on_floor():
		velocity.x -= velocity.x * DRAG * delta
	move_and_slide()

func _physics_process(delta):
	$Camera2D.position_smoothing_speed = max(5, log(velocity.length()) * 5)

func disable_jump():
	can_jump = false
