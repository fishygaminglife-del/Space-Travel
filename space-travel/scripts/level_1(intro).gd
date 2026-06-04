extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MC/Text.text = "Hi"
	$MC/AnimationPlayer.play("text_playname")
	await wait_for_text_end()
	$MC/Text.text = "w friend"
	$MC/AnimationPlayer.play("text_playname")
	await wait_for_text_end()
	$MC/Textbox.visible = false
	$MC/Name.visible = false
	$MC/Text.visible = false

func wait_for_text_end():
	while $MC/AnimationPlayer.is_playing():
		await get_tree().process_frame
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
