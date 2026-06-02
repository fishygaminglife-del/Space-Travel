extends Node2D



func _ready() -> void:
	$AnimatedSprite2D2.visible = false
	$AnimatedSprite2D2.play("default")
	$AnimatedSprite2D.play("default")
	$AnimationPlayer.play("spaceship crash")
	await $AnimationPlayer.animation_finished
	$AnimatedSprite2D.pause()
	$AnimatedSprite2D2.visible = true
	$AnimationPlayer.play("spaceshipfire")
	await $AnimationPlayer.animation_finished
	$loadmenu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
