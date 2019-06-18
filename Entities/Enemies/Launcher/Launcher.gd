#Flying Launcher
extends KinematicBody2D

# Constants

const UP = Vector2(0, -1)
# const GRAVITY = 20

export (float) var gravity = 5
export (float) var velocity = 2
export (Vector2) var motion = Vector2()

export (float) var max_distance = 700

export (int) var _shoot_direction_axis = -1 # could be -1 or 1

export (int) var facing = 1

var first_pos = self.get_global_position()

# Survival variables
var is_dead = false
var attacking = false

# Shooting Variables
var can_shoot = true
const FORCE_BALL = preload("res://Powers/enemyPowers/force_ball/force_ball.tscn")



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
	$areaDetection/detectionShape.disabled = true
	$entityCollision.disabled = true
	yield($animation, "animation_finished")
	
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
			force_ball.launch(_shoot_direction, _shoot_direction_axis)
			
			force_ball.beforeVanish()
			
			_shoot_direction *= -1 # EQUALS TO +1 positive right
			force_ball_pos = $pos_right_cannon.global_position
			
			force_ball = FORCE_BALL.instance()
			get_parent().add_child(force_ball)
			force_ball.position = force_ball_pos
			force_ball.launch(_shoot_direction, _shoot_direction_axis)
			
			force_ball.beforeVanish()
			
		can_shoot = true
		attacking = false
		
	
func _physics_process(delta):
	
	motion.y += gravity - gravity
	
	# print($distanceGround.get_collision_point())
	
	$Label.text = str($launcher_health.get_health())
	
	if is_dead == false:
		if attacking == false:
			$animation.play("idle")
		
		motion.x = velocity * facing
		
		if self.get_global_position().x > abs(first_pos.x + max_distance) or self.get_global_position().x < abs(first_pos.x - max_distance):
			first_pos.x = get_global_position().x
			facing *= -1
		
		var collide = move_and_collide(motion)
		
		if collide:
			_on_impact(collide.normal)
		
		
		
	if is_on_wall():
		facing *= -1
		
func _on_impact(normal):
	facing *= -1
	pass