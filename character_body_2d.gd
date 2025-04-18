class_name player
extends CharacterBody2D

@onready var sprite = $Sprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var frog = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if frog == true:
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_pressed("left"):
		sprite.skew = -0.3
		sprite.flip_h = true
	else:
		if Input.is_action_just_released("right"):
			sprite.skew = 0
			
	if Input.is_action_pressed("right"):
		sprite.skew = 0.3
		sprite.flip_h = false
	else:
		if Input.is_action_just_released("left"):
			sprite.skew = 0

	move_and_slide()

func dead_frog():
	frog = true
	sprite.play("Frog")
