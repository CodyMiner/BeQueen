extends RigidBody2D


var drag := 0.08
var has_pher := true
var is_queen := false


func _process(_delta):
	var impulse = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		impulse += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		impulse += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		impulse += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		impulse += Vector2(1, 0)
	impulse = impulse.normalized() * 20
	linear_velocity *= 1-drag
	linear_velocity += impulse


func _on_PherTimer_timeout():
	$Particles2D.emitting = false
	has_pher = false
