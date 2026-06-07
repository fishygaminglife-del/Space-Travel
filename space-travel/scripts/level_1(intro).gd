extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.hearts = 8
	$MC/Text.text = "Welcome to Space Travel, explore planets, defeat the aliens, gear up, and save humanity!"
	$MC/Name.text = "The Voice"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Use arrow keys and WASD to move and jump. E to pick up items, B for backpack."
	$MC/AnimationPlayer.play("text_playname2")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "R to rotate your main slot, F to use your item."
	$MC/AnimationPlayer.play("text_playname2")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Notice Colors and what they signify."
	$MC/AnimationPlayer.play("text_playname2")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Dodge aliens, and defeat the boss, good luck!"
	$MC/AnimationPlayer.play("text_playname2")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	Global.can_skip = false
	$MC/Textbox.visible = false
	$MC/Name.visible = false
	$MC/Text.visible = false
	$lvl1anim.play("1barriergone")

func wait_for_text_end():
	while $MC/AnimationPlayer.is_playing():
		await get_tree().process_frame

func _process(delta: float) -> void:
	pass
