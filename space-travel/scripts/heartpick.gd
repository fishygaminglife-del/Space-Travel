extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Global.hearts < 5:
			Global.hearts += 1
			$".".visible = false
			$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
		else:
			print("Max Hearts")
