extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D/Text.text = "Hi"
	$CharacterBody2D/AnimationPlayer.play("text_playname")
	await wait_for_text_end()
	$CharacterBody2D/Text.text = "w friend"
	$CharacterBody2D/AnimationPlayer.play("text_playname")
	await wait_for_text_end()
	$CharacterBody2D/Textbox.visible = false
	$CharacterBody2D/Name.visible = false
	$CharacterBody2D/Text.visible = false

func wait_for_text_end():
	while $CharacterBody2D/AnimationPlayer.is_playing():
		await get_tree().process_frame
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
