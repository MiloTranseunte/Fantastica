extends Node

const HEALTH = 100

func _damage(hit):
	var health = HEALTH - hit
	return health

func _get_health():
	return HEALTH