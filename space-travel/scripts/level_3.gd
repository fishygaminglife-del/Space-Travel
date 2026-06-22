extends Node2D
var shop = false
var player_in_shop = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		if player_in_shop == true:
			$MC/shoping.visible = true
			$shope.visible = false
func _ready() -> void:
	if Global.previously_shield == true:
		Global.shield_enabled = true
		
	$MC/shoping.visible = false
	$shope.modulate.a = 0.0
	Global.can_skip = true	
	$MC/Text.text = "This is an icy place, oh no ice..."
	$MC/Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$MC/Text.text = "Ice"
	$MC/Name.text = "Ash (You)"
	$MC/AnimationPlayer.play("text_playname")
	await get_tree().process_frame
	await get_node("MC").wait_for_skip()
	$Level3.play("Shop_Setup")
	$MC/Textbox.visible = false
	$MC/Name.visible = false
	$MC/Text.visible = false
	
	shop = true
#Shop Items Below
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
	elif $MC.shield_active == false and $MC/Shield.visible == false and $MC/Shieldside.visible == false:
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
		Global.coins -= 5
		$MC/Potionspeed.visible = true
		$MC.slot_1 = true
	elif $MC.slot_2 == false:
		print("gotitem")
		Global.coins -= 5
		$MC/Potionspeed2.visible = true
		$MC.slot_2 = true
	elif $MC.slot_1 and $MC.slot_1:
		$MC/shoping/Label3.text = "Slots Used"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label3.text = "5C"
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
	pass # Replace with function body.
func _on_xbut_pressed() -> void:
	get_tree().paused = false
	$shope.visible = true
	$MC/shoping.visible = false
func _on_shopbut_pressed() -> void:
	$MC/shoping.visible = true
	$shope.visible = false
	get_tree().paused = true
func _on_button_4_pressed() -> void:
	if Global.coins < 5:
		$MC/shoping/Label2.text = "Insufficent Coins"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label2.text = "5C"
	elif $MC.iceskates == false:
		Global.coins -= 5
		$MC.iceskates = true
		
	elif $MC.iceskates == true:
		$MC/shoping/Label2.text = "Already Own Item"
		await get_tree().create_timer(1).timeout
		print("timed")
		$MC/shoping/Label2.text = "5C"
