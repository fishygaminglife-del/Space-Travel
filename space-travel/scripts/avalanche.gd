extends Node2D

@export var speed = 80
@export var height_offset := 32.0
@export var ResX = 0
@export var ResY = 0
@export var StartX = 0
@export var StartY = 0
var target_y := 0.0
func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	if Global.avalanche == true:
		position.x += speed * delta
		if $RayCast2D.is_colliding():
			var hit_pos = $RayCast2D.get_collision_point()
			target_y = hit_pos.y - height_offset

		global_position.y = lerp(global_position.y, target_y, 5.0 * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.avalanche = false
		$avalanche.stop()
		$".".position = Vector2(StartX, StartY)
		body.position = Vector2(ResX, ResY)
		$"../AvaRes".monitorable = true
		$"../AvaRes/CollisionShape2D".set_deferred_thread_group("disabled", false)
		Global.hearts -=1
		body.degrade()
