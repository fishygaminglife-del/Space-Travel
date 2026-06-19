extends CharacterBody2D

const JUMP_VELOCITY = -460
var idle_time = 0.0
var last_facing = 1
var shield_active = false
@export var speed = 155
var gravity_scale = 1.0
var player_dead = false
var has_shield = false
var shield_hits = randi_range(3, 25)
var shield_hit = 0
var slot_1 = false
var slot_2 = false

func wait_for_skip():
	print("waiting for skip")
	await get_tree().process_frame

	while !Input.is_action_just_pressed("skip"):
		await get_tree().process_frame
	print("skip pressed")

func _ready() -> void:
	player_dead = false
	Global.dead = false
	$MCCharacter.play("sideidle2")
			
func degrade():
	if Global.hearts == 0:
		Global.dead = true
		player_dead = true
		velocity.x = 0
		$hearts2/heart1.play("default")
		print("died")
		$MCCharacter.play("death")
		await $MCCharacter.animation_finished
		Global.hearts = 4
		get_tree().reload_current_scene()
	elif Global.hearts == 1: 
		$hearts2/heart2.play("default")
	elif Global.hearts == 2:
		$hearts2/heart3.play("default")
	elif Global.hearts == 3:
		$hearts2/heart4.play("default")
	elif Global.hearts == 4:
		$hearts2/heart5.play("default")
	elif Global.hearts == 5:
		$hearts2/heart6.play("default")
	elif Global.hearts == 6:
		$hearts2/heart7.play("default")
	elif Global.hearts == 7:
		$hearts2/heart8.play("default")
func upgrade():
	
	if Global.hearts == 2:
		$hearts2/heart2.stop()
		$hearts2/heart2.frame = 0
		print("upgrade")
	elif Global.hearts == 3:
		$hearts2/heart3.stop()
		$hearts2/heart3.frame = 0
		print("upgrade")
	elif Global.hearts == 4:
		$hearts2/heart4.stop()
		$hearts2/heart4.frame = 0
		print("upgrade")
	
func _process(delta):
	if slot_1 == false:
		$"slot 1".visible = false
		$"slot1-1".visible = false
	else: 
		$"slot 1".visible = true
		$"slot1-1".visible = true
	if slot_2 == false:
		$"slot 2".visible = false
		$"slot2-1".visible = false
	else: 
		$"slot 2".visibe = true
		$"slot2-1".visible = true
	$coins.text = str(Global.coins)
	if shield_hit >= shield_hits:
		Global.shield_enabled = false
		shield_active = false
		$Shieldside.visible = false
		$Shield.visible = false
	if Global.level < 4:
		$hearts2/heart8.visible = false
		$hearts2/heart7.visible = false
		$hearts2/heart6.visible = false
		$hearts2/heart5.visible = false
	if Global.shield_enabled == false:
		shield_active = false
		$Shield.visible = false
		$Shieldside.visible = false
	elif Input.is_action_pressed("shield"):
		shield_active = true
		$Shield.visible = true
		$Shieldside.visible = false
	else:
		shield_active = false
		$Shield.visible = false
		$Shieldside.visible = true
		
func _physics_process(delta: float) -> void:
	platformer_movement(delta)

func platformer_movement(delta):

	if not is_on_floor():
		velocity.y += get_gravity().y * gravity_scale * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		if !player_dead:
			idle_time = 0.0
			last_facing = direction
			velocity.x = direction * speed
			$MCCharacter.speed_scale = 1.0
			$MCCharacter.play("side")
			$MCCharacter.flip_h = direction < 0
			$Shield.flip_h = direction > 0
			$Shieldside.flip_h = direction> 0

	else:
		if !player_dead:
			$MCCharacter.speed_scale = 0.5
			velocity.x = move_toward(velocity.x, 0, speed)
			idle_time += delta
			if idle_time > 0.15:
				if last_facing > 0:
					$MCCharacter.play("sideidle2")
				elif last_facing < 0:
					$MCCharacter.play("sideidle2")
	move_and_slide()


func _on_button_2_pressed() -> void:
	if $Potionspeed.visible:
		slot_1 = false
		speed = 200
		$Potionspeed.visible = false
		await get_tree().create_timer(10).timeout
		speed = 155 


func _on_button_3_pressed() -> void:
	if $Potionspeed.visible:
		slot_1 = false
		speed = 200
		$Potionspeed.visible = false
		await get_tree().create_timer(10).timeout
		speed = 155 


func _on_slot_21_pressed() -> void:
	if $Potionspeed2.visible:
		slot_2 = false
		speed = 200
		$Potionspeed2.visible = false
		await get_tree().create_timer(10).timeout
		speed = 155 


func _on_slot_2_pressed() -> void:
	if $Potionspeed2.visible:
		slot_2 = false
		speed = 200
		$Potionspeed2.visible = false
		await get_tree().create_timer(10).timeout
		speed = 155 
