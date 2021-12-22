extends Node

const CLONE = preload("res://Entities/Clone/Clone.tscn")

onready var player = $Player
onready var loopTimer = $Timer

var playerInitialPos = Vector2.ZERO

var isRecording : bool = false
var positionList : Array = []

export var totalLoops : int
export var loopTime : float
var currentLoop : int = 0

func _ready():
	isRecording = true
	loopTimer.wait_time = loopTime
	loopTimer.start()
	currentLoop += 1
	playerInitialPos = player.position

func _process(delta):
	_recording()
	_force_clone()

func _recording():
	positionList.append(player.position)

func _reset():
	positionList = []
	playerInitialPos = Vector2(playerInitialPos.x, playerInitialPos.y - 40)
	player.position = playerInitialPos
	
	if(currentLoop < totalLoops):
		loopTimer.start()
	
	currentLoop += 1

func _on_Timer_timeout():
	_add_clone()
	_reset()

func _force_clone():
	if(Input.is_action_just_pressed("Clone") and currentLoop <= totalLoops):
		loopTimer.stop()
		_add_clone()
		_reset()

func _add_clone():
	var cloneInstance = CLONE.instance()
	cloneInstance.positionList = positionList
	add_child(cloneInstance)
	cloneInstance.position.x = playerInitialPos.x
	cloneInstance.position.y = playerInitialPos.y
