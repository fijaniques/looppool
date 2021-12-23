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
	if(totalLoops > 0):
		loopTimer.start()
	currentLoop += 1
	playerInitialPos = player.position
	$CanvasLayer/RichTextLabel.bbcode_text = "THIS IS A TEXT TEST"

func _process(delta):
	_recording()
	_force_clone()
	_text()

func _text():
	$CanvasLayer/RichTextLabel.bbcode_text = "Loop " + str(currentLoop - 1) + "/" + str(totalLoops) + ": " + str("%1.2f" % $Timer.time_left)

func _recording(): #adding player position to list
	positionList.append(player.position) 

func _reset(): #reseting position list and player position avoiding collision bug, increasing loop number
	positionList = []
	playerInitialPos = Vector2(playerInitialPos.x, playerInitialPos.y - 40)
	player.position = playerInitialPos
	
	if(currentLoop < totalLoops):
		loopTimer.start()
	
	currentLoop += 1

func _on_Timer_timeout(): #time untill reset
	_add_clone()
	_reset()

func _force_clone(): #reset before timer ends
	if(Input.is_action_just_pressed("Clone") and currentLoop <= totalLoops):
		loopTimer.stop()
		_add_clone()
		_reset()

func _add_clone(): #create clone instance, transfer position list, add clone to scene and change it`s position
	var cloneInstance = CLONE.instance()
	cloneInstance.positionList = positionList
	add_child(cloneInstance)
	cloneInstance.position = playerInitialPos
