extends RigidBody2D


var duration : float

onready var enemies := get_parent().get_parent().get_node("Enemies")
onready var pher_timer := get_parent().get_node("PherTimer")
onready var progress_bar = get_parent().get_node("ProgressBar")


func _on_Stinger_body_entered(body):
	if body.is_alive:
		duration = body.pher
		body.die()
		get_parent().get_node("Particles2D").emitting = true
		progress_bar.max_value = duration
		progress_bar.value = duration
		pher_timer.start(duration)
		get_parent().has_pher = true
