extends KinematicBody2D


var velocity = Vector2.ZERO # 速度
export var ACCELERATION = 10 # 加速度
export var MAX_SPEED = 100 # 最大速度
export var FRICTIION = 10 # 摩擦力

func _physics_process(delta):
	var input_vector = Vector2.ZERO # 输入速度
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_vector != Vector2.ZERO:
		velocity += input_vector * delta * ACCELERATION
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(velocity.ZERO, FRICTIION*delta)
	move_and_collide(velocity)