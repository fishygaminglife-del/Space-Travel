extends Area2D
var falling = false
var start_position: Vector2
var player
@export var fall_speed := 400
@export var ogfall_speed := 400
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	start_position = global_position
	player = get_tree().get_first_node_in_group("player")
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		falling = false
		Global.hearts -= 1
		body.degrade()
		$AnimatedSprite2D.play("icicle crash")
		$".".monitorable = false
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(3).timeout
		global_position = start_position
		falling = false

		$AnimatedSprite2D.visible = true
		$".".monitorable = true
		$AnimatedSprite2D.play("default")
		
	elif body.is_in_group("collision") or body.is_in_group("enemy"):
		falling = false
		$CollisionPolygon2D.set_deferred_thread_group("disabled", true)
		$AnimatedSprite2D.play("icicle crash")
		$".".monitorable = false
		await $AnimatedSprite2D.animation_finished
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(3).timeout
		global_position = start_position
		$AnimatedSprite2D.visible = true
		$".".monitorable = true
		$AnimatedSprite2D.play("default")
	
func _physics_process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("player")
	if !falling and player:
		if abs(player.global_position.x - global_position.x) <= 70:
			if player.global_position.y > global_position.y:
				falling = true
				print("fall")
	if falling == true:
		position.y += fall_speed * delta
	
