extends ProgressBar


onready var timer = get_parent().get_node("PherTimer")


func _process(_delta):
	if not timer.is_stopped():
		value = timer.time_left
	
