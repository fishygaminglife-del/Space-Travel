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
			$AnimatedSprite2D.play("goo_splat")
			Global.hearts -= 1
			body.degrade()
			queue_free()
			return
			await get_tree().create_timer(0.2).timeout
			$AnimatedSprite2D.play("default")
	if body.is_in_group("collision"):
		$AnimatedSprite2D.play("goo_splat")
		await get_tree().create_timer(0.1).timeout
		$AnimatedSprite2D.play("default")
	if reflected and body.is_in_group("alien"):
		body.queue_free()
		queue_free()
