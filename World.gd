extends Node2D


onready var enemy = preload("res://Enemy.tscn")

func reset_world():
	var positions = [
		Vector2(100, 300)
	]
