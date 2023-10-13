extends RigidBody2D
class_name Ball

signal destroyed(Ball)

const MAX_SPEED : float = 150.0
const RADIUS : float = 32
const MIN_PITCH_VARIATION : float = 0.8
const MAX_PITCH_VARIATION : float = 1.2

@export var speed : float = 30.0
@export var speed_increment : float = 0.5

@onready var audio_hit_paddle := $AudioHitPaddle
@onready var audio_hit_walls := $AudioHitWalls


func set_direction(direction : Vector2):
	linear_velocity = direction * speed


func _on_body_entered(body):
	speed = min(speed + speed_increment, MAX_SPEED)
	linear_velocity = linear_velocity.normalized() * speed
	
	if body is Paddle and not audio_hit_paddle.playing:
		audio_hit_paddle.pitch_scale = randf_range(MIN_PITCH_VARIATION, MAX_PITCH_VARIATION)
		audio_hit_paddle.play()
		_get_paddle_ricochet(body)
	elif body is Block:
		body.take_damage()
	elif not audio_hit_walls.playing:
		audio_hit_walls.pitch_scale = randf_range(MIN_PITCH_VARIATION, MAX_PITCH_VARIATION)
		audio_hit_walls.play()


func destroy():
	destroyed.emit(self)
	queue_free()


func _get_paddle_ricochet(paddle):
	var direction = global_position - paddle.global_position
	linear_velocity = direction.normalized() * speed
