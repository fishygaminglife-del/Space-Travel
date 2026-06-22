extends CharacterBody2D
const JUMP_VELOCITY = -460
var idle_time = 0.0
var last_facing = 1
var shield_active = false
@export var speed = 155
var gravity_scale = 1.0
var player_dead = false
var has_shield = false
var shield_hits = randi_range(3, 22)
var shield_hit = 0
var slot_1 = false
var slot_2 = false
var max_bar_width = 100.0


func wait_for_skip():
	print("waiting for skip")
	await get_tree().process_frame

	while !Input.is_action_just_pressed("skip"):
		await get_tree().process_frame
	print("skip pressed")

func _physics_process(delta: float) -> void:
	platformer_movement(delta)

func platformer_movement(delta):

	if not is_on_floor():
		velocity.y += get_gravity().y * gravity_scale * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		if !player_dead:
			idle_time = 0.0
			last_facing = direction
			velocity.x = direction * speed
			$MCCharacter.speed_scale = 1.0
			$MCCharacter.play("side")
			$MCCharacter.flip_h = direction < 0
			$Shield.flip_h = direction > 0
			$Shieldside.flip_h = direction> 0

	else:
		if !player_dead:
			$MCCharacter.speed_scale = 0.5
			velocity.x = move_toward(velocity.x, 0, speed)
			idle_time += delta
			if idle_time > 0.15:
				if last_facing > 0:
					$MCCharacter.play("sideidle")
				elif last_facing < 0:
					$MCCharacter.play("sideidle2")
	move_and_slide()
