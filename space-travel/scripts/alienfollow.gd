extends CharacterBody2D
var player
var speed = 40
var gravity = 900

func _ready() -> void:
	$alienanifol.play("default")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	

	if player.global_position.x > global_position.x:
		velocity.x = speed
		$alienanifol.flip_h = false
	elif player.global_position.x < global_position.x:
		velocity.x = -speed
		$alienanifol.flip_h = true
	else:
		velocity.x = 0
	move_and_slide()
