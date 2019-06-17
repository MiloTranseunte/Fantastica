#Flying Launcher
extends KinematicBody2D

# Constants

const UP = Vector2(0, -1)
# const GRAVITY = 20
export (float) var angle = 45
export (float) var shoot_force = 50

export (float) var gravity = 100
export (float) var velocity = 40
export (Vector2) var motion = Vector2()

# Survival variables
var is_dead = false
var attacking = false

# Shooting Variables
var can_shoot = true
const FORCE_BALL = preload("res://Powers/enemyPowers/force_ball/force_ball.tscn")

var facing = 1

var animation_playing

func takeDamage(hitPoint):
	if is_dead == false:
		var health = $launcher_health._damage(hitPoint)
		if health <= 0:
			_dead()


func _dead():
	is_dead = true
	motion = Vector2(0,0) 
	$animation.play("dead")
	yield($animation, "animation_finished")
	$areaDetection/detectionShape.disabled = true
	$entityCollision.disabled = true
	queue_free()
	pass
	
func shootTrigered():
	attacking = true
	
	if is_dead == false && can_shoot == true:
		can_shoot = false
		
		$animation.play("attack")
		yield($animation, "animation_finished")
		
		if $animation.get_animation() != "dead":
			var _shoot_direction = -1 # negative left
			var force_ball_pos = $pos_left_cannon.global_position
			
			var force_ball = FORCE_BALL.instance()
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
			
		can_shoot = true
		attacking = false
	
func _physics_process(delta):
	
	motion.y += gravity - gravity
	
	print($distanceGround.get_collision_point())
	
	$Label.text = str($launcher_health.get_health())
	
	if is_dead == false:
		if attacking == false:
			$animation.play("idle")
		
		motion.x = velocity * facing
		
		motion = move_and_slide(motion, UP)
		
	if is_on_wall():
		facing *= -1