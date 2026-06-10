extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$goo.position = Vector2(5049.5, 1200)
	$MC/Camera2D.make_current()
	$bg.visible = true
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
	$lvl1anim.play("bossmove")
	await $lvl1anim.animation_finished
	$boss/boss2.make_current()
	$animeintro/AnimationPlayer.play("introduction")
	for i in range(3):
		print("start")
		$boss/boss.frame = 0
		$boss/boss.play("default")
		await $boss/boss.animation_finished
		print("end")
	
	$boss/boss.frame = 0
	$boss/boss.play("throwup")
	await $boss/boss.animation_finished
	$MC/Camera2D.make_current()
	$lvl1anim.play("goomSove")
	$goo.play("default")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(0.2).timeout
		print("Entered:", body.name)
		print("restart")
		get_tree().reload_current_scene()
	$goo.position = Vector2(5049.5, 1200)
