# Launcher ENEMY Health
extends Node

export (float) var health = 100

func _damage(hitpoint):
	health = health - hitpoint
	return health
	pass

func _ready():
	pass

func get_health():
	return health