extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED_FALL = 1000
const ACCELERATION = 75
const MAX_SPEED = 220 #220
const JUMP_HEIGHT = -550

const BULLET = preload("res://Powers/playerPowers/Fireball/Fireball.tscn")

export (String, FILE, "*.tscn") var Next_World

var motion = Vector2()

var can_shoot = true

var is_dead = false

func takeDamage(hitPoint):
	if is_dead == false:
		var remained_health = $health._damage(hitPoint)
		if remained_health <= 0:
			_dead()
			pass
		
func _dead():
	is_dead = true
	motion = Vector2(0,0)
	$Sprite.play("dead")
	yield($Sprite, "animation_finished")
	$entityCollision.disabled = true
	queue_free()
	get_tree().change_scene(Next_World)

func _physics_process(delta):
	
	$Label.text = str($health.health)
	
	var bullet_pos = $Position2D.global_position #Vector2()
	
	motion.y += GRAVITY
	
	var air_friction = false
	
	
	if is_dead == false:
		if Input.is_action_pressed("goRight"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("Run")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("goLeft"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("Run")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			$Sprite.play("Idle")
			air_friction = true
		
		if is_on_floor():
			if Input.is_action_pressed("Jump"):
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
				
		if Input.is_action_pressed("shoot"):
			var bullet = BULLET.instance()
			shoot(bullet, bullet_pos)
			
			
		if Input.is_action_just_pressed("reset_world"):
			get_tree().change_scene(Next_World)
		
		"""
		Just for experimental use only
		"""
		if Input.is_action_just_pressed("takeDamage"):
			var hit = 25
			takeDamage(hit)
	
	motion = move_and_slide(motion, UP)
	
func shoot(bullet, bullet_pos):
	if can_shoot == true:
		if sign($Position2D.position.x) == -1:
			bullet.set_bullet_direction(-1)
		else:
			bullet.set_bullet_direction(1)
	
		get_parent().add_child(bullet)
		bullet.position = bullet_pos
		
		can_shoot = false
		$shootingDelay.start()
		

func _on_shootingDelay_timeout():
	can_shoot = true
