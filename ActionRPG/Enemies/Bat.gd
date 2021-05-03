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


func _ready():
	print(stats.max_health)

func _physics_process(delta):
	match state:
		IDLE:
			pass
		WANDER:
			pass
		CHASE:
			pass
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	move_and_slide(velocity)











func _on_Hurtbox_area_entered(area):

	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect(sprite)
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








































