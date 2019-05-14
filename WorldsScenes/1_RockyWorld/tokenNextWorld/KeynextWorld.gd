extends Area2D

export (String, FILE, "*.tscn") var Next_World

#func _physics_process(delta):
#	var bodies = get_overlapping_bodies()
#	get_tree().change_scene(Next_World)


# 	for body in bodies:
#		if body.name == "Player":
#			print("overlapping body here")

func _on_KeynextWorld_body_entered(body):
	get_tree().change_scene(Next_World)
