extends KinematicBody2D

# Constants

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED_FALL = 1000
const ACCELERATION = 10
const MAX_SPEED = 220

# Motion variables
var motion = Vector2()

# Survival variables
var health = 25
var is_dead = false

# Shooting Variables
var can_shoot = true
# const BULLET = preload("res://Powers/enemyPowers/Fireball/enemyFireball.tscn")

func takeDamage(hitPoint):
	health = health - hitPoint
	if health <= 0:
		dead()
		
func dead():
	is_dead = true
	motion = Vector2(0,0) 
	$Sprite.play("idle")
	$entityCollision.disabled = true
	$areaDetection/detectionShape.disabled = true
	# $Timer.start()
	pass