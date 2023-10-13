extends Node2D

@export var main_paddle_holder : Player

var balls : Array[Ball]

@onready var ball_scene : PackedScene = preload("res://Scenes/Ball/Ball.tscn")

func _ready():
	spawn_ball(position, true)

func spawn_ball(spawn_position : Vector2, is_attached_to_paddle : bool):
	var new_ball : Ball = ball_scene.instantiate()
	balls.append(new_ball)
	
	if is_attached_to_paddle :
		main_paddle_holder.attach_ball_to_paddle(new_ball)
	
	new_ball.destroyed.connect(_on_Ball_destroyed)
	$BallsHolder.add_child(new_ball)


func _on_Ball_destroyed(target : Ball):
	var position = balls.find(target)
	balls.remove_at(position)
	
	if balls.is_empty():
		print("no balls left")
