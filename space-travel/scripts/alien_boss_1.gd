extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".play("default")




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Entered:", body.name)
		print(body)
		get_tree().reload_current_scene()
