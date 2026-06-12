extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$space.play("default")
	$insideship.play("default")
	$MC.gravity_scale = 0
	$MC.speed = 150
	$Text.text = "Whoa this technology is advanced!"
	$Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$Text.text = "Maybe I could save other planets, is that goo, yuck!"
	$Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$Text.text = "Look another planet, time to defeat that boss."
	$Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	get_tree().change_scene_to_file("res://scenes/lvl2intro.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
