# PLAYER HEALTH
extends Node

var health = 100

func _damage(hit):
	health = health - hit
	return health
	
func get_health():
	return health