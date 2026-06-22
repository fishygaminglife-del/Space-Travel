extends Area2D

var direction = Vector2.ZERO
var speed = 200
var reflected = false
var shooter = null
var start_position: Vector2
@export var max_distance := 500
var can_hit_player := true
var timepass = 0.0

func _physics_process(delta: float) -> void:
	timepass += delta
	position += direction * speed * delta
	if reflected and can_hit_player:
		can_hit_player = false
		await get_tree().create_timer(0.05).timeout

	
func _on_body_entered(body: Node2D) -> void:
	
		if body.is_in_group("player"):
			if body.shield_active and !reflected:
				body.shield_hit += 1
				print("Shield durability:", body.shield_hit, "/", body.shield_hits)
				if randi() % 5 == 0:
					reflected = true
					can_hit_player = false
					if shooter != null:
						direction = (shooter.global_position - global_position).normalized()
				else:
					speed = 0
					$AnimatedSprite2D.play("ice_splat")
					await $AnimatedSprite2D.animation_finished
					queue_free()
					return

			else:
				print("x")
				if randi() % 10 == 0:
					Global.hearts -= 1
					body.degrade()
				body.apply_slow()
				print("slowed")
				speed = 0
				reparent(body)
				$AnimatedSprite2D.play("ice_splat")
				await $AnimatedSprite2D.animation_finished
				queue_free()
				return


		elif body.is_in_group("collision"):
			print('stopped')
			speed = 0
			$AnimatedSprite2D.play("ice_splat")
			await $AnimatedSprite2D.animation_finished
			queue_free()
		
		elif body.is_in_group("enemy"):
			if timepass > 0.1:
				body.queue_free()
				queue_free()
