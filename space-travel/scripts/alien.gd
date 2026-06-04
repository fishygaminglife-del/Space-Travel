extends CharacterBody2D

var speed = 50
var distance_right = 60
var distance_left = 60
var start_x
var target_x
var moving_right = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	start_x = position.x
	target_x = start_x + distance_right

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving_right:
		position.x += speed * delta 
		if position.x >= target_x:
			moving_right = false
			target_x = start_x - distance_left
	else:
		$AnimatedSprite2D.flip_h = true
		position.x -= speed * delta
		if position.x <= target_x:
			moving_right = true
			target_x = start_x + distance_right
			$AnimatedSprite2D.flip_h = false
