extends Node

export var max_health = 1 setget set_max_health    #最大生命值

var health = max_health setget set_health          # 生命值


# 生命值信号
signal health_changed(value)                       
signal max_health_changed(value)
signal no_health


func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
	

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("health_changed", max_health)
