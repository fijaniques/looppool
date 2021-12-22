extends KinematicBody2D

const UPDIRECTION = Vector2.UP

var gravity : float = 1000
var speed : float = 100
var jumpForce : float = -500
var maxJumps : int = 2
var velocity = Vector2.ZERO

var jumpsMade : int = 0

func _physics_process(delta : float) -> void:
	_motion(delta)
	_jump()

func _motion(delta : float):
	var hDir = Input.get_action_strength("Right") - Input.get_action_strength("Left") #direção horizontal entre 1 e -1
	velocity.x = hDir * speed #direção horizontal multiplicada pela velocidade (negativo pra esquerda e positivo pra direita)
	velocity.y += gravity * delta #força da gravidade aplicada o tempo todo (y positivo para baixo)
	
	velocity = move_and_slide(velocity, UPDIRECTION)
	
func _jump():
	if(Input.is_action_just_pressed("Jump") and is_on_floor()): #pula apenas se estiver no chão
		velocity.y = jumpForce 
