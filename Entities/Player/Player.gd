extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED_FALL = 1000
const ACCELERATION = 50
const MAX_SPEED = 5000 #200
const JUMP_HEIGHT = -550

const BULLET = preload("res://Powers/playerPowers/Fireball/Fireball.tscn")

export (String, FILE, "*.tscn") var Next_World

var motion = Vector2()



func _physics_process(delta):
	
	var bullet_pos = $Position2D.global_position #Vector2()
	
	motion.y += GRAVITY
	
	var air_friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		$Sprite.play("Idle")
		air_friction = true
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if air_friction == true:
			motion.x = lerp(motion.x, 0, .2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
			motion.y = lerp(motion.y, MAX_SPEED_FALL, .01)
			
		if air_friction == true:
			motion.x = lerp(motion.x, 0, .2)
			
	if Input.is_action_just_pressed("ui_down"):
		var bullet = BULLET.instance()
		if sign($Position2D.position.x) == -1:
			bullet.set_bullet_direction(-1)
		else:
			bullet.set_bullet_direction(1)
		get_parent().add_child(bullet)
		bullet.position = bullet_pos
		
	if Input.is_action_just_pressed("reset_world"):
		get_tree().change_scene(Next_World)
		
	$Label.text = 'veloctiyY: ' + str(motion.y)+ ' ' + 'VelocityX: ' + str(motion.x)
	
	motion = move_and_slide(motion, UP)
	
	
	pass