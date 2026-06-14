extends CharacterBody2D
var player
@export var speed = 50.0
@export var action = ""
@export var shoot_range = 300
var gravity = 900
var can_shoot = true
@export var follow_distance = 590
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	player = get_tree().get_first_node_in_group("player")


	
func _physics_process(delta: float) -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")
		return
	if player:
		if !Global.dead:
			var distance = global_position.distance_to(player.global_position)
			if distance <= shoot_range:
				shoot()

	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	if !Global.dead:
		var distance = global_position.distance_to(player.global_position)
		if distance > follow_distance:
			velocity.x = 0
		else:
			if player.global_position.x > global_position.x:
				velocity.x = speed
				$AnimatedSprite2D.flip_h = false
			elif player.global_position.x < global_position.x:
				velocity.x = -speed
				$AnimatedSprite2D.flip_h = true
			else:
				velocity.x = 0
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Entered:", body.name)
		print(body)
		if str(action) == "kill":
			Global.hearts -= 10
			$AnimatedSprite2D.visible = false
			$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
			$CollisionPolygon2D2.set_deferred("disabled", true)
			print("hearts" + str(Global.hearts))
			$"../../MC".degrade()
		else:
			Global.hearts -= 1
			$".".visible = false
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			$CollisionShape2D.set_deferred("disabled", true)
			print("hearts" + str(Global.hearts))
			$"../MC".degrade()
			


func shoot():
	if !can_shoot:
		return

	can_shoot = false

	var goo = preload("res://scenes/gooball.tscn").instantiate()
	goo.global_position = global_position
	goo.start_position = goo.global_position

	goo.direction = (player.global_position - global_position).normalized()
	goo.shooter = self

	get_parent().add_child(goo)

	await get_tree().create_timer(1.5).timeout
	can_shoot = true
