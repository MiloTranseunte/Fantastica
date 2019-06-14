extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED_FALL = 1000
const ACCELERATION = 75
const JUMP_HEIGHT = -550

const FIREBALL = preload("res://Powers/playerPowers/Fireball/Fireball.tscn")
export (String, FILE, "*.tscn") var Next_World

export (int) var max_speed = 220 #220

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
	$entityCollision.disabled = true
	$Sprite.play("dead")
	yield($Sprite, "animation_finished")
	queue_free()
	get_tree().change_scene(Next_World)

func _physics_process(delta):
	
	$Label.text = str($health.get_health())
	var fireball_pos = $Position2D.global_position #Vector2()
	
	motion.y += GRAVITY
	
	var air_friction = false
	
	if is_dead == false:
		if Input.is_action_pressed("goRight"):
			motion.x = min(motion.x + ACCELERATION, max_speed)
			$Sprite.flip_h = false
			$Sprite.play("Run")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("goLeft"):
			motion.x = max(motion.x - ACCELERATION, -max_speed)
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
				motion.y = lerp(motion.y, max_speed, .01)

			if air_friction == true:
				motion.x = lerp(motion.x, 0, .2)

		if Input.is_action_pressed("shoot"):
			var fireball = FIREBALL.instance()
			_shoot(fireball, fireball_pos)


#		 Just for experimental use only

		if Input.is_action_just_pressed("reset_world"):
			get_tree().change_scene(Next_World)

		if Input.is_action_just_pressed("takeDamage"):
			var hit = 25
			takeDamage(hit)

		motion = move_and_slide(motion, UP)


func _shoot(fireball, fireball_pos):
	if can_shoot == true:
		if sign($Position2D.position.x) == -1:
			fireball.set_bullet_direction(-1)
		else:
			fireball.set_bullet_direction(1)
		
		get_parent().add_child(fireball)
		fireball.position = fireball_pos
		
		can_shoot = false
		$shootingDelay.start()
		
		fireball.beforeVanish()


func _throw(knife, knife_pos):
	if can_shoot == true:
		if sign($Position2D.position.x) == -1:
			knife.set_knife_direction(-1)
		else:
			knife.set_knife_direction(1)

		get_parent().add_child(knife)
		knife.position = knife_pos
		
		can_shoot = false
		$shootingDelay.start()
		
		knife.beforeVanish()


func _on_shootingDelay_timeout():
	can_shoot = true
