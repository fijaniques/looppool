extends KinematicBody2D

var positionList = []
var n : int = 0

func _process(delta):
	_movement()

func _movement():
	if(n < positionList.size()):
		position = positionList[n]
		n += 1
