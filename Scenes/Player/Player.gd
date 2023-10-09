extends Node2D

class_name Player

@export var right_input : String = "right"
@export var left_input : String = "left"

@onready var paddle : Paddle = $Paddle

func _process(delta):
	var move = Input.get_axis(left_input, right_input)
	
	if move < 0:
		paddle.move_left(delta)
	elif move > 0:
		paddle.move_right(delta)
