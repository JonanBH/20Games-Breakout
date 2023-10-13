extends StaticBody2D
class_name Block

signal destroyed(Block)

@export var health_colors : Array[Color]

var current_health : int :
	set(value):
		current_health = value
		_update_health_color()

func _ready():
	current_health = health_colors.size()

func take_damage():
	current_health -= 1
	if current_health <= 0:
		_explode()


func _explode():
	destroyed.emit(self)
	queue_free()


func _update_health_color():
	var current_color : int = max((current_health - 1), 0)
	$Sprite2D.modulate = health_colors[current_color]
