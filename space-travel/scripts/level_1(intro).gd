extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Spaceshipside/AnimatedSprite2D.play("default")
	$goo.position = Vector2(5049.5, 1200)
	$MC.position = Vector2(-923, 569)
	$MC.visible = true
	$MC/Camera2D.make_current()
	$bg.visible = true
	Global.hearts = 4
	$MC/Text.text = "Where am i... what happened to my home earth!"
	$MC/Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Welcome to Space Travel, explore planets, defeat many creatures, and save your home!"
	$MC/Name.text = "The Voice"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Use arrow keys and WASD to move and jump. E to pick up items, B for backpack. Space to use your main item (you don't have it yet)."
	$MC/AnimationPlayer.play("text_playname2")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Dodge aliens, defeat the boss, and save humanity, good luck!"
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
	if body.is_in_group("player"):
		$BossStart/CollisionShape2D.set_deferred("disabled", true)
		$lvl1anim.play("bossmove")
		await $lvl1anim.animation_finished
		$aliens/AlienBOss.position = Vector2(5345, -312)
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
		$lvl1anim.play("goomove")
		$goo.play("default")


func _on_gooarea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("GOO TRIGGERED BY:", body.name)
		print("GROUPS:", body.get_groups())
		print("Player:", $MC.global_position)
		print("Goo:", $goo.global_position)
		$goo.position = Vector2(5049.5, 1200)
		Global.hearts -= 1
		$lvl1anim.seek(0, true)
		$lvl1anim.stop()
		$MC.degrade()
		$MC.position = Vector2(4327, 587)
		$aliens/AlienBOss.position = Vector2(4769, 520)
		$BossStart/CollisionShape2D.set_deferred("disabled", false)
		print("Entered:", body.name)
		print("restart")


func _on_shapeship_body_entered(body: Node2D) -> void:
	Global.level = 2
	Global.coins = int(str($MC/coins))
	$lvl1anim.play("spaceshipleave1")
