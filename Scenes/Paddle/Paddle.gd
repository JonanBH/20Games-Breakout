extends CharacterBody2D
class_name Paddle

@export var base_speed : float = 20
@export var shoot_min_rotation : float = 5
@export var shoot_max_rotation : float = 15

var attached_ball : Ball = null

func _process(delta):
	if attached_ball != null:
		attached_ball.global_position = $BallPosition.global_position


func move_right(delta):
	velocity = Vector2.RIGHT.rotated(global_rotation) * base_speed * delta
	move_and_collide(velocity)


func move_left(delta):
	velocity = Vector2.LEFT.rotated(global_rotation) * base_speed * delta
	move_and_collide(velocity)

func attach_ball(ball : Ball):
	attached_ball = ball

func shoot_ball():
	if attached_ball == null :
		return
		
	var direction : Vector2 = Vector2.UP.rotated(global_rotation)
	var offset_rotation = lerp(shoot_min_rotation, shoot_max_rotation, abs(velocity.length()))
	var offset_signal = velocity.dot(Vector2.RIGHT.rotated(global_rotation))
	offset_signal = 1 if offset_signal > 0 else -1
	
	direction = direction.rotated(deg_to_rad(offset_rotation * offset_signal))
	
	attached_ball.set_direction(direction)
	attached_ball = null
