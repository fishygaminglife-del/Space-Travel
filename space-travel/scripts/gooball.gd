extends Area2D

var direction = Vector2.ZERO
var speed = 200
var reflected = false
var shooter = null
var start_position: Vector2
@export var max_distance := 500

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		if body.shield_active and !reflected:
			
			if randi() % 5 == 0:
				reflected = true

				if shooter != null:
					direction = (shooter.global_position - global_position).normalized()
				else:
					queue_free()

				return

		else:
			speed = 0
			reparent(body)
			$AnimatedSprite2D.play("goo_splat")
			Global.hearts -= 1
			body.degrade()
			await $AnimatedSprite2D.animation_finished
			queue_free()
			return

	elif body.is_in_group("collision"):
		speed = 0
		$AnimatedSprite2D.play("goo_splat")
		await $AnimatedSprite2D.animation_finished
		queue_free()
		
	
	if reflected and body.is_in_group("alien"):
		body.queue_free()
		queue_free()
