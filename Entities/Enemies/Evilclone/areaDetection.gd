extends Area2D

var timer = null
var bullet_delay = 2
var can_shoot = true

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_delay)
	timer.connect("timeout", self, "on_timeout_complete")
	
func on_timeout_complete():
	can_shoot = true
	

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && can_shoot == true:
			can_shoot = false
			print("here")
			timer.start()
			get_parent().shoot() #Parent is Enemy
