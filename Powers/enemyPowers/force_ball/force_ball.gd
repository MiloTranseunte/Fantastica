extends KinematicBody2D

const THROW_VELOCITY = Vector2(300, -200)
#						Vector angle.y * magnitud, angle.y * magnitud
export (float) var angle = deg2rad(2574)
var force = 1
var gravity = 300
var velocity = Vector2.ZERO

# to take into account: get_viewport().get_mouse_position()

func beforeVanish():
	$Timer.set_wait_time(4)
	$Timer.start()

func _physics_process(delta):
	velocity.y += gravity * delta
	
	var collision = move_and_collide(velocity * delta)
	
	if collision != null:
		_on_impact(collision.normal)
	
	pass


func launch(direction, _shoot_direction_axis):
	velocity = THROW_VELOCITY * Vector2(direction, _shoot_direction_axis) # segundo término, cambia entre (1) y (-1)


func _on_impact(normal : Vector2):
	queue_free()
	
	# To bounce
	#velocity = velocity.bounce(normal)
	#velocity *= 0.5 + rand_range(-0.05, 0.05)
	pass



func _on_Timer_timeout():
	queue_free()
