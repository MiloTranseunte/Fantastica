extends Area2D

export (String, FILE, "*.tscn") var Next_World

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(Next_World) 
