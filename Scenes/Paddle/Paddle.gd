extends CharacterBody2D
class_name Paddle

@export var base_speed : float = 20

var y_position : float = 0

func _ready():
	y_position = position.y

func _physics_process(delta):
	position.y = y_position

func move_right(delta):
	velocity = Vector2.RIGHT * base_speed * delta
	move_and_collide(velocity)


func move_left(delta):
	velocity = Vector2.LEFT * base_speed * delta
	move_and_collide(velocity)
