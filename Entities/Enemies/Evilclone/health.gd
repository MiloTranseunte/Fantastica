extends Node

var health = 100

func _damage(hit):
	health = health - hit
	return health