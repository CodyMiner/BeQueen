extends Area2D


func _ready():
	pass


func _on_Path_body_entered(enemy):
	if not enemy.is_targetting():
		enemy.back_and_forth($CollisionShape2D.shape)


func _on_Path_body_exited(enemy):
	if not enemy.is_targetting():
		enemy.back_and_forth($CollisionShape2D.shape)
