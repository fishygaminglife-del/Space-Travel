extends CharacterBody2D
var player
@export var speed = 50.0
@export var action = ""
var gravity = 900
@export var follow_distance = 590
func _ready() -> void:
	$alienanifol.play("default")
	player = get_tree().get_first_node_in_group("player")


	
func _physics_process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	var distance = global_position.distance_to(player.global_position)

	if distance > follow_distance:
		velocity.x = 0
	else:
		if player.global_position.x > global_position.x:
			velocity.x = speed
			$alienanifol.flip_h = false
		elif player.global_position.x < global_position.x:
			velocity.x = -speed
			$alienanifol.flip_h = true
		else:
			velocity.x = 0
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if str(action) == "kill":
			Global.hearts -= 10
			$alienanifol.visible = false
			$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
			$CollisionPolygon2D2.set_deferred("disabled", true)
			print("hearts" + str(Global.hearts))
			$"../../MC".degrade()
		else:
			Global.hearts -= 1
			$".".visible = false
			$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
			$CollisionPolygon2D2.set_deferred("disabled", true)
			print("hearts" + str(Global.hearts))
			$"../../MC".degrade()
