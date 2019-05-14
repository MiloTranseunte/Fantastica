#areaDetection2D parent is EvilClone

extends Area2D

func _ready():
	pass

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_parent().shootTrigered() #Parent is EvilClone
	pass
