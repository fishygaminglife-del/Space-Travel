extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$AnimationPlayer.play("lvl2intro")
	await $AnimationPlayer.animation_finished
	$loadmenu.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level2.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/homescreen.tscn")
