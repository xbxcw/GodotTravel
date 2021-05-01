extends KinematicBody2D


export var ACCELERATION = 500 # 加速度
export var MAX_SPEED = 80 # 最大速度
export var FRICTIION = 500 # 摩擦力

var velocity = Vector2.ZERO # 速度

enum{
	MOVE,
	ROLL,
	ATTACK
}

func _physics_process(delta):
	var input_vector = Vector2.ZERO # 输入速度
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTIION * delta)
	
	velocity = move_and_slide(velocity)
	print(velocity)
	
func roll_animation_finished():
	pass
func attack_animation_finished():
	pass
