extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MC/Camera2D.make_current()
	Global.hearts = 4
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


func _on_boss_start_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(0.8).timeout
	$boss/boss2.make_current()
	$boss/boss2/Text.text = "The Alien Knight is gooing, outrun them both!"
	$boss/boss2/AnimationPlayer.play("text_playname")
	for i in range(3):
		$boss/boss.play("default")
		await $boss/boss.animation_finished
	
	$boss/boss.play("throwup")
	await $boss/boss.animation_finished
	$MC/Camera2D.make_current()
