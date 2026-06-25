extends Node2D
var shop = false
var player_in_shop = false
var can_b_intro = true
var can_a_intro = true
var in_fire = false
var boss_fight = false
var boss_burn = false
func _ready() -> void:
	Global.hearts = 4
	$BossBurn/AnimatedSprite2D4.play("default")
	$BossBurn/boss2.play("default")
	$BossBurn/boss2/boss3.play("default")
	$fire1.play("default")
	$fire2.play("default")
	$animeintro/boss.play("default")
	$animeintro/good.play("default")
	$AnimatedSprite2D3.play("default")
	$arrow.play("default")
	Global.shield_enabled = true
	$MC/Camera2D.make_current()
	$MC/Shieldside.visible = true
	$MC/shoping.visible = false
	$shope.modulate.a = 0.0
	Global.can_skip = true
	$MC/Text.text = "I have a shield? and im on mars..."
	$MC/Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Press Control to use shield, block gooballs and possibly reflect them back!"
	$MC/Name.text = "The Voice"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Press E near the shop to use the shop and buy items to aid you."
	$MC/Name.text = "The Voice"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	shop = true
	$AnimationPlayer.play("shopsetup")
	Global.can_skip = false
	$MC/Textbox.visible = false
	$MC/Name.visible = false
	$MC/Text.visible = false

func _process(delta: float) -> void:
	if can_a_intro:
		pass
		
	if Input.is_action_just_pressed("e"):
		if player_in_shop == true:
			$MC/shoping.visible = true
			$shope.visible = false
			
func _on_shoparea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and shop == true:
		player_in_shop = true
		$shope.modulate.a = 1.0
		$shope.visible = true
		print("worked")
	
func _on_button_pressed() -> void:
	if Global.coins < 10:
		$MC/shoping/Label.text = "Insufficent Coins"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label.text = "10C"
	elif Global.hearts != 4:
		Global.coins -= 10
		Global.hearts += 1
		$MC.upgrade()
	elif Global.hearts > 3:
		$MC/shoping/Label.text = "Max Health"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label.text = "10C"
		
func _on_shoparea_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_shop = false
		$MC/shoping.visible = false

func _on_button_2_pressed() -> void:
	if Global.coins < 15:
		$MC/shoping/Label2.text = "Insufficent Coins"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label2.text = "15C"
	elif $MC.shield_active == false and boss_fight == false and $MC/Shield.visible == false and $MC/Shieldside.visible == false:
		$MC.shield_hit = 0
		Global.shield_dead = false
		Global.coins -= 15
		Global.shield_enabled = true
		$MC.shield_hits = randi_range(2, 25)
		
	elif Global.shield_enabled == true:
		$MC/shoping/Label2.text = "Already Own Item"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label2.text = "15C"
func _on_button_3_pressed() -> void:
	print("pressed")
	if Global.coins < 2:
		$MC/shoping/Label3.text = "Insufficent Coins"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label3.text = "2C"
	elif $MC.slot_1 == false:
		print("gotitem")
		Global.coins -= 2
		$MC/Potionspeed.visible = true
		$MC.slot_1 = true
	elif $MC.slot_2 == false:
		print("gotitem")
		Global.coins -= 2
		$MC/Potionspeed2.visible = true
		$MC.slot_2 = true
	elif $MC.slot_1 and $MC.slot_1:
		$MC/shoping/Label3.text = "Slots Used"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label3.text = "2C"

func _on_button_mouse_entered() -> void:
	$MC/shoping/shopheart.visible = true
	$MC/shoping/shopheart.play("default")

func _on_button_mouse_exited() -> void:
	$MC/shoping/shopheart.visible = true
	$MC/shoping/shopheart.stop()

func _on_button_3_mouse_entered() -> void:
	$MC/shoping/shoppot.visible = true
	$MC/shoping/shoppot.play("default")

func _on_button_3_mouse_exited() -> void:
	$MC/shoping/shoppot.visible = true
	$MC/shoping/shoppot.stop()

func _on_b_button_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_a_intro:
		can_a_intro = false
		$boss_but.play("buttonpressed")
		await $boss_but.animation_finished
		$MC/Text.text = "Outrun the lava on the path -->"
		$MC/Name.text = "The Voice"
		$MC/AnimationPlayer.play("text_playname")
		$AnimationPlayer.play("blockform")
		$boss_but.play("lavarise")
		await get_tree().process_frame
		await get_node("MC").wait_for_skip()
		$MC/Textbox.visible = false
		$MC/Name.visible = false
		$MC/Text.visible = false

func _on_bossintro_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_b_intro == true:
		boss_fight = true
		can_b_intro = false
		Global.shield_enabled = false
		Global.can_skip = true
		$MC/Text.text = "You think your stronger, HAHAHAHA! Let's see how strong you are with no shield."
		$MC/Name.text = "???"
		$MC/AnimationPlayer.play("text_playname")
		if $MC.has_shield == true:
			Global.has_shield = true
		Global.shield_enabled = false
		$MC/Shield.visible = false
		$MC/Shieldside.visible = false
		
		await get_tree().process_frame
		await get_node("MC").wait_for_skip()
		$MC/Text.text = "My goo shoots through walls!"
		$MC/Name.text = "???"
		await get_tree().process_frame
		await get_node("MC").wait_for_skip()
		$MC/Textbox.visible = false
		$MC/Name.visible = false
		$MC/Text.visible = false
		$animeintro/animeintrocam.make_current()
		Global.shield_enabled = false
		$MC.shield_active = false
		$MC/Shield.visible = false
		$MC/Shieldside.visible = false
		$animeintro/AnimationPlayer.play("introduction")
		await $animeintro/AnimationPlayer.animation_finished
		$MC/Camera2D.make_current()
		$AnimationPlayer.play("boss2open")
		await get_tree().create_timer(1).timeout
		Global.B2_shoot = true

func _on_lava_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		can_a_intro = true
		Global.B2_shoot = false
		$boss_but.seek(0, true)
		$boss_but.play("buttonpressed")
		$boss_but.stop()
		$boss_but.seek(0, true)
		$AnimationPlayer.seek(0, true)
		can_a_intro = false
		$boss_but.stop()
		$boss_but.clear_queue()
		can_b_intro = true
		Global.hearts -= 1
		if Global.hearts != 0:	
			$MC.position = Vector2(5264, 589)
		$MC.degrade()
		
func _on_shapeship_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and boss_burn == false:
		if $MC.has_shield == true:
			Global.previously_shield = true
		boss_burn = true
		#var tree = get_tree()
		Global.level = 3
		print(Global.level)
		Global.save_game()
		$BossBurn/bossburn.make_current()
		$BossBurn/BOSSBURN.play("boss_burn")
		$BossBurn/Name.text = "Drone"
		$BossBurn/Text.text = "HELP YOU BURNED ME!!!"
		$BossBurn/insideship2.play("text_playname")
		await $BossBurn/BOSSBURN.animation_finished
		$MC/Camera2D.make_current()	
		$MC/Text.text = "I have to get out of here..."
		$MC/Name.text = "Ash (You)"
		$MC/Textbox/tbskip.visible = false
		$MC/AnimationPlayer.play("text_playname")
		$AnimationPlayer.play("enter_spaceship")
		await $AnimationPlayer.animation_finished
		print("tree after await:", get_tree())
		get_tree().change_scene_to_file("res://scenes/insidespaceship_2.tscn")
	
func _on_xbut_pressed() -> void:
	get_tree().paused = false
	$shope.visible = true
	$MC/shoping.visible = false

func _on_shopbut_pressed() -> void:
	$MC/shoping.visible = true
	$shope.visible = false
	get_tree().paused = true

func _on_fireboduy_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		in_fire = true
		Global.hearts -= 1
		$MC.degrade()
		await get_tree().create_timer(1).timeout
		while in_fire == true:
			Global.hearts -= 1
			$MC.degrade()
			await get_tree().create_timer(1).timeout

func _on_fireboduy_body_exited(body: Node2D) -> void:
		in_fire = false


func _on_bosebody_body_exited(body: Node2D) -> void:
	can_a_intro = true
	can_b_intro = true
	Global.B2_shoot = false
	$boss_but.play("buttonpressed")
	$boss_but.stop()
	$boss_but.seek(0, true)
	$AnimationPlayer.seek(0, true)
	$boss_but.stop()
	$boss_but.clear_queue()
