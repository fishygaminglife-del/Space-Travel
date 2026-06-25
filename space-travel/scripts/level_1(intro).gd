extends Node2D
var boss_fight = false

func _ready() -> void:
	Global.shield_enabled = false
	$Spaceshipside/AnimatedSprite2D.play("default")
	$goo.position = Vector2(5049.5, 1200)
	$MC.visible = true
	$MC/Camera2D.make_current()
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
		if boss_fight == false:
			$lvl1anima.play("bossmove")
			await $lvl1anima.animation_finished
			$aliens/AlienBOss.position = Vector2(5345, -312) 
			print("not happening")
			boss_fight = true
		
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
		$BossStart/CollisionShape2D.set_deferred("disabled", false)
		print("Entered:", body.name)
		print("restart")


func _on_shapeship_body_entered(body: Node2D) -> void:
	var tree = get_tree()
	Global.level = 2
	print(Global.level)
	Global.coins = int(str($MC/coins))
	Global.save_game()
	$MC/Text.text = "I vow to come back and save earth!"
	$MC/Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	$lvl1anim.play("spaceshipleave1")
	await $lvl1anim.animation_finished
	print("tree after await:", get_tree())
	tree.change_scene_to_file("res://scenes/insidespaceship.tscn")
	
