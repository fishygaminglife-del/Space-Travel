extends Node2D



func _ready() -> void:
	$loadmenu.visible = false
	$Spaceship2.play("default")
	if Global.played_before == true:
		$loadmenu/Label.text = "CONTINUE"
	$AnimatedSprite2D.frame = 1
	$Burntearth.visible = false
	$AnimatedSprite2D2.visible = false
	$AnimatedSprite2D2.play("default")
	$AnimatedSprite2D.play("default")
	$AnimationPlayer.play("spaceship crash")
	await $AnimationPlayer.animation_finished
	$AnimatedSprite2D.pause()
	$AnimatedSprite2D2.visible = true
	$AnimationPlayer.play("spaceshipfire")
	await $AnimationPlayer.animation_finished
	$Burntearth.visible = true
	$loadmenu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	Global.load_game()


func _on_restart_pressed() -> void:
	Global.reset_game()
