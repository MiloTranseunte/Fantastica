extends Area2D

#Bullet of the Player

const SPEED = 750
var velocity = Vector2()
var direction = 1

func set_bullet_direction(dir):
	direction = dir

func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	
	if direction == 1:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
		
	translate(velocity)




func _on_Bullet_body_entered(body):
	if "RockyTile" or "Enemy" in body.name:
		print(body.name)
		queue_free()
		if "Enemy" in body.name:
			body.dead()
