extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$MC.speed = 0
	$Text.text = "What is happening with these alien invasions, looks like I am the protector."
	$Spaceshipbarrier/insideship2.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$Text.text = "Is that another room?"
	$Spaceshipbarrier/insideship2.play("text_playname")
	await get_tree().create_timer(1).timeout
	$spaceship2.play("moving to other room")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$Text.text = "Is that ice? My Shield!"
	$Spaceshipbarrier/insideship2.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$Text.text = "It looks like it's another planet."
	$Spaceshipbarrier/insideship2.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	get_tree().change_scene_to_file("res://scenes/lvl3intro.tscn")
