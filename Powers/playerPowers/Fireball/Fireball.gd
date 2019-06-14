extends Area2D

#Bullet of the Player

const SPEED = 550
var velocity = Vector2()
var direction = 1

var hitPoint = 50


func set_bullet_direction(dir):
	direction = dir


func beforeVanish():
	$Timer.set_wait_time(1.5)
	$Timer.start()


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	$Sprite.play("fireball")
	
	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
		
	translate(velocity)



func _on_Timer_timeout():
	print("bullet_queued")
	queue_free()


func _on_fireball_body_entered(body):
	body.call_deferred("takeDamage", hitPoint) # la sintáxis de call_deferred te salva del error: #"can't change this state while flushing queries" # y hace funcionar mejor las colisiones
	queue_free()
