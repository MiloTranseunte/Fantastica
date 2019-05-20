extends Area2D

const hitPoint = 10

var bodies
var can_damage = true


func delayDamage(body):
	body.takeDamage(hitPoint)
	yield(get_tree().create_timer(0.5), "timeout")
	can_damage = true
	
func _physics_process(delta):
	bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && can_damage == true:
			can_damage = false
			delayDamage(body)
	pass
