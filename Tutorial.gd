extends Control

func _input(key):
	if key.is_action_pressed("ui_up"):
		fair_game()
	if key.is_action_pressed("ui_down"):
		fair_game()
	if key.is_action_pressed("ui_left"):
		fair_game()
	if key.is_action_pressed("ui_right"):
		fair_game()

func fair_game():
	get_parent().get_node("PherTimer").start()
	queue_free()
