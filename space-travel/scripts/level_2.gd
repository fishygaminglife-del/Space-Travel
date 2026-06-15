extends Node2D
var shop = false
func _ready() -> void:
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


func _on_shoparea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and shop == true:
		$shope.modulate.a = 1.0
		print("visible")
