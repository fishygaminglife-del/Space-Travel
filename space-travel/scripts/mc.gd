extends CharacterBody2D

const JUMP_VELOCITY = -300
var idle_time = 0.0
var last_facing = 1
var speed = 150

func _physics_process(delta: float) -> void:
	platformer_movement(delta)

func platformer_movement(delta):
	#Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	#Jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		idle_time = 0.0
		last_facing = direction
		velocity.x = direction * speed
		$MCCharacter.play("side")
		$MCCharacter.flip_h = direction < 0

	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		idle_time += delta
		if idle_time > 0.15:
			if last_facing > 0:
				$MCCharacter.play("sideidle2")
			elif last_facing < 0:
				$MCCharacter.play("sideidle2")
