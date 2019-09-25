extends KinematicBody2D

# Gravity and motion Constants
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED_FALL = 1000
const ACCELERATION = 10
const MAX_SPEED = 220

# Motion Variables
var motion = Vector2()
var direction = 1

# Survival variables
#var health = 200
var is_dead = false

# Shooting Variables
var can_shoot = true
const BULLET = preload("res://Powers/enemyPowers/Fireball/enemyFireball.tscn")

func takeDamage(hitPoint):
	if is_dead == false:
		var health = $health._damage(hitPoint)
		if health <= 0:
			_dead()


func _dead():
	is_dead = true
	motion = Vector2(0,0) 
	$Sprite.play("dead")
	$areaDetection/detectionShape.disabled = true
	$touchingArea/CollisionShape2D.disabled = true
	$entityCollision.disabled = true
	yield($Sprite, "animation_finished")
	
	queue_free()

# TODO: DELETE
#func touchDamage():
#	pass
	
func shootTrigered():
	if is_dead == false && can_shoot == true:
		can_shoot = false
		
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
		
		bullet.beforeVanish()
		
		$shootingDelay.start()
	
func _ready():
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	
	$Label.text = str($health.get_health())
	motion.y += min(GRAVITY, MAX_SPEED_FALL) # Always falling
	motion.x = lerp(motion.x, 0, .1)
	
	if is_dead == false:
		
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

func _on_shootingDelay_timeout():
	can_shoot = true
	pass


func _on_touchingArea_body_entered(body):
	if body.name == "Player":
	 body.takeDamage(10)
