extends Node2D



func _on_deadZone_body_entered(body):
	if body.name == "Player":
		body.takeDamage(100)
