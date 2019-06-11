#Knife of the Player
extends KinematicBody2D

# Where is UP?
const UP = Vector2(0, -1)
# Knife Gravity
const _GRAVITY = 4

#Knife Angle
export (float) var knife_angle = 45 setget set_knife_angle
#Knife Speed
export (int) var knife_speed = 30

# Directional Force
var directional_force = Vector2()
#Motion variable
var motion = Vector2()

#Get player Direction
var player_direction = -1

#Amount of damage
export (int) var hitPoint = 50

func beforeVanish():
	$Timer.set_wait_time(1.5)
	$Timer.start()
	pass
	
func set_knife_angle(value):
	knife_angle = clamp(value, 0, 359)
	
func update_directional_force():
	directional_force = Vector2(cos(knife_angle*(PI/180)), sin(knife_angle*(PI/180))) * knife_speed

func _ready():
	update_directional_force()
	
func set_knife_direction(dir):
	player_direction = dir

func _physics_process(delta):
	motion.x = directional_force.x * player_direction
	motion.y += delta * _GRAVITY
	#motion.y += directional_force.y * delta * _GRAVITY
	#motion.y += delta * _GRAVITY
	
	move_and_collide(motion)
	pass

func _on_Timer_timeout():
	print("knife_queued")
	queue_free()
