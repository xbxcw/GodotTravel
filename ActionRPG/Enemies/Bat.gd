extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/DeathEffect.tscn")

export var ACCELERAION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4



enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE

onready var sprite = $AnimatedSprite
onready var stats = $stats
onready var hurtbox = $Hurtbox
onready var playerDetectionZone = $PlayerDetectionZone
onready var softCollision = $SoftCollision
onready var animationPlayer = $AnimationPlayer
onready var wanderController = $WanderController

func _ready():
	print(stats.max_health)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta) # 击退
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			# 待机
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			# 漫游
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			# 追赶
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
			
	if softCollision.is_colliding():
		# 防止重叠
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)



func accelerate_towards_point(point, delta):
	# 加速前进
	var direction = global_position.direction_to(point)
	velocity = velocity .move_toward(direction * MAX_SPEED, ACCELERAION * delta)
	sprite.flip_h = velocity.x < 0



func seek_player():
	# 发现玩家
	if playerDetectionZone.can_see_player():
		state = CHASE


# 更新漫游状态
func update_wander():
	state = pick_random_state([IDLE, WANDER]) # 随机获取一个状态
	wanderController.start_wander_timer(rand_range(1, 3))

# 随机状态
func pick_random_state(state_list):
	state_list.shuffle() # 随机列表
	return state_list.pop_front() # 提取列表里的第一个，并从列表里删除

func _on_Hurtbox_area_entered(area):

	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)
	


func _on_stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_Hurtbox_invincibility_started():
	pass # Replace with function body.


func _on_Hurtbox_invincibility_ended():
	pass # Replace with function body.








































