extends KinematicBody2D

const _GRAVITY = 10

var point_a = 30
var point_b = -30

var place = Vector2(30, -30)
var motion = Vector2()

var arc_height = 45

func _ready():
	pass
	
func _physics_process(delta):
	motion = calculate_arc_velocity(point_a, point_b, arc_height)
	motion = move_and_slide(motion, Vector2(0, -1))
	pass
	
func calculate_arc_velocity(point_a, point_b, arc_height, gravity = _GRAVITY):
	var velocity = Vector2()
	
	var displacement = point_b - point_a
	
	if displacement > arc_height:
		var time_up = sqrt(-2 * arc_height / float(gravity))
		var time_down = sqrt(2 * (displacement - arc_height) / float(gravity))
		
		velocity.y = -sqrt(-2 * gravity * arc_height)
		velocity.x = displacement.x / float(time_up - time_down)
	pass

	return velocity