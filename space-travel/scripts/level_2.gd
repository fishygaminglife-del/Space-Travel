extends Node2D
var shop = false
var player_in_shop = false
func _ready() -> void:
	Global.shield_enabled = true
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
	
	elif Global.hearts != 4:
		Global.coins -= 10
		Global.hearts += 1
		$MC.upgrade()
	elif Global.hearts > 3:
		$MC/shoping/Label.text = "Max Health"


func _on_shoparea_body_exited(body: Node2D) -> void:
	player_in_shop = false
	$MC/shoping.visible = false


func _on_button_2_pressed() -> void:
	if Global.coins < 15:
		$MC/shoping/Label2.text = "Insufficent Coins"
	
	elif Global.shield_enabled == false:
		Global.coins -= 15
		Global.shield_enabled = true
		$MC.shield_hits = randi_range(2, 25)
		$MC.upgrade()
	elif Global.shield_enabled == true:
		$MC/shoping/Label2.text = "Already Own Item"
		
func _on_button_3_pressed() -> void:
	print("pressed")
	if Global.coins < 5:
		$MC/shoping/Label2.text = "Insufficent Coins"
		print("no coins")
	elif $MC/Potionspeed.visible == false:
		print("gotitem")
		Global.coins -= 5
		$MC/Potionspeed.visible = true
	elif $MC/Potionspeed.visible == true:
		$MC/shoping/Label2.text = "Already Own Item"
		print("alreadyhave")


func _on_button_mouse_entered() -> void:
	$MC/shoping/shopheart.visible = true
	$MC/shoping/shopheart.play("default")


func _on_button_mouse_exited() -> void:
	$MC/shoping/shopheart.visible = true
	$MC/shoping/shopheart.stop()
