extends Area2D

#Knife of the Player
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 10

var motion = Vector2()

var direction = 1
var hitPoint = 50

func set_knife_direction(dir):
	direction = dir
	
func beforeVanish():
	$Timer.set_wait_time(1.5)
	$Timer.start()
	pass

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.y += GRAVITY * delta
	motion.x = SPEED * direction
	
	translate(motion)
	pass

func _on_Timer_timeout():
	print("knife_queued")
	queue_free()
