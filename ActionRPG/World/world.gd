extends Node2D


var gameoverUI = "res://UI/GameOver.tscn"


func _ready():
	$AudioStreamPlayer.play()
	PlayerStats.connect("no_health",self,"change_gameoverUI")


func change_gameoverUI():
	get_tree().change_scene(gameoverUI)

