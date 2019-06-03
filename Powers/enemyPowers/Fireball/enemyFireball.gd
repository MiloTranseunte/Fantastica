extends Area2D

const SPEED = 350
var velocity = Vector2()
var direction = 1

var hitPoint = 15

func set_bullet_direction(dir):
	direction = dir

func _ready():
	pass # Replace with function body.

func beforeVanish():
	$Timer.set_wait_time(1.5)
	$Timer.start()

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	$Sprite.play("fireball")

	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true

	translate(velocity)




#func _on_Bullet_body_entered(body):
#	pass




func _on_Bullet_enemy_body_entered(body):
	body.call_deferred("takeDamage", hitPoint)
	queue_free()

#	if "EvilClone" in body.name:
#		body.dead()


func _on_Timer_timeout():
	print("enemy bullet queued")
	queue_free()
