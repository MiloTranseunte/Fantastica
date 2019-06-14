#Flying Launcher
extends KinematicBody2D

# Constants

const UP = Vector2(0, -1)
# const GRAVITY = 20
export (float) var angle = 45
export (float) var shoot_force = 50

export (float) var gravity = 100
export (float) var velocity = 20
export (Vector2) var motion = Vector2()

# Survival variables
var is_dead = false

# Shooting Variables
var can_shoot = true
const FORCE_BALL = preload("res://Powers/enemyPowers/Fireball/enemyFireball.tscn")

var facing = 1

func takeDamage(hitPoint):
	if is_dead == false:
		var health = $health._damage(hitPoint)
		if health <= 0:
			_dead()


func _dead():
	is_dead = true
	motion = Vector2(0,0) 
	$Sprite.play("idle")
	$entityCollision.disabled = true
	$areaDetection/detectionShape.disabled = true
	# $Timer.start()
	pass
	
func _physics_process(delta):
	motion.x = velocity * facing

	var force_ball_pos = 0 # $pos_left_cannon.global_position

	var force_ball = FORCE_BALL
	
	if Input.is_action_just_pressed("throw"): # SPACEBAR
	
		var _shoot_direction = -1 # negative left
		force_ball_pos = $pos_left_cannon.global_position
		force_ball = FORCE_BALL.instance()
		get_parent().add_child(force_ball)
		force_ball.position = force_ball_pos
		force_ball.launch(_shoot_direction)
		
		force_ball.beforeVanish()
		
		_shoot_direction *= -1 # EQUALS TO +1 positive right
		force_ball_pos = $pos_right_cannon.global_position
		force_ball = FORCE_BALL.instance()
		get_parent().add_child(force_ball)
		force_ball.position = force_ball_pos
		force_ball.launch(_shoot_direction)
		
		force_ball.beforeVanish()
		
	motion = move_and_slide(motion, Vector2(0, -1))
		
	if is_on_wall():
		print("wall")
		facing *= -1
	
	pass