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
#onready var playerDetectionZone =













func _on_Hurtbox_area_entered(area):
	pass # Replace with function body.
