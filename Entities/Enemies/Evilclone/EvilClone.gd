extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED_FALL = 1000

const ACCELERATION = 10
const MAX_SPEED = 220

var is_dead = false

var motion = Vector2()
var direction = 1

var can_shoot = true

const BULLET = preload("res://Powers/enemyPowers/Fireball/enemyFireball.tscn")

func takeDamage(hitPoint):
	
	return 

func dead():
	is_dead = true
	motion = Vector2(0,0)
	$Sprite.play("idle")
	$entityCollision.disabled = true
	$areaDetection/detectionShape.disabled = true
	$Timer.start()
	
	
func shootTrigered():
	
	if is_dead == false && can_shoot == true:
		print("enemy is shooting")
	
		var bullet_pos = $Position2D.global_position
		var bullet = BULLET.instance()
		# SET DIRECTION
		if sign($Position2D.position.x) == -1:
			bullet.set_bullet_direction(-1)
		else:
			bullet.set_bullet_direction(1)
		#SET DIRECTION ENDS
		
		get_parent().add_child(bullet)
		bullet.position = bullet_pos
		
		can_shoot = false
		$shootingDelay.start()
	
func _ready():
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	
	if is_dead == false:
		motion.y += min(GRAVITY, MAX_SPEED_FALL) # Always falling
		
		motion.x = lerp(motion.x, 0, .1)
		
		if direction == 1: #RIGHT
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("run")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		else: #LEFT
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("run")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		
		if motion.x == 0:
			$Sprite.play("idle")
		
		if !is_on_floor():
			motion.y = lerp(motion.y, MAX_SPEED_FALL, .01)
			
		motion = move_and_slide(motion, UP)
		
		if is_on_wall():
			direction *= -1

#func _on_Area2D_body_entered(body):
#	if "Player" in body.name:
#		print(body.name + " this")
#		$Timer.start()
#	else:
#		$Timer.stop()
#		print("StopShooting")

#func _on_Area2D_body_exited(body):
#	pass


func _on_Timer_timeout():
	queue_free()

func _on_shootingDelay_timeout():
	can_shoot = true
	pass
