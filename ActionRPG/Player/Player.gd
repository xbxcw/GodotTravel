extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var ACCELERATION = 500 # 加速度
export var MAX_SPEED = 80 # 最大速度
export var ROLL_SPEED = 120 # 最大翻滚速度
export var FRICTIION = 500 # 摩擦力

var velocity = Vector2.ZERO # 移动方向
var roll_vector = Vector2.DOWN # 翻滚方向
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var animationState = animationTree.get("parameters/playback")
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer


enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO # 输入速度
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector #翻滚方向等于移动方向
		swordHitbox.knockback_vector = input_vector # 攻击方向等于移动方向
		
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		animationTree.set('parameters/Attack/blend_position', input_vector)
		animationTree.set('parameters/Roll/blend_position', input_vector)
		animationState.travel('Run')
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, FRICTIION * delta)
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK
		
		
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
	move()
	
func move():
	velocity = move_and_slide(velocity)

# warning-ignore:unused_argument
func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel('Roll')
	move()
# warning-ignore:unused_argument
func attack_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel('Attack')
	
func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE


func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage 
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	
func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

