extends Node2D

func _ready() -> void:
	$bg.play("default")
	$boss2.play("default")
	$boss.play("default")
	$AnimatedSprite2D3.play("default")
	$AnimationPlayer.play("rotate enemies")
	$MCCharacter.play("sideidle2")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/homescreen.tscn")
