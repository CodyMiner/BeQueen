extends RigidBody2D


const THETA := PI/4 

var is_alive := true
var speed := 120
var in_agro_pher := false
var in_agro_no_pher := false
var pher : float = 4.0

onready var player = get_tree().get_root().get_node("World/Player")
onready var world = get_tree().get_root().get_node("World")


func _ready():
	$Sprite.modulate = Color(2, 1, 1)
	$AudioStreamPlayer2D.play()
	linear_damp = 1
	linear_velocity = Vector2(speed, 0).rotated(rand_range(0, 2*PI))


func _process(_delta):
	if is_alive:
		if is_targetting():
			target()
		else:
			move_chaotically()


func target():
	angular_velocity = -4
	var pos_relative_to_player : Vector2 = position - player.position
	linear_velocity = -pos_relative_to_player.normalized() * speed


func _on_Stinger_body_entered(body):
	if is_alive:
		if body.get_parent() == get_parent():
			die()
			body.die()
		elif body.name == "Player":
			var _ignore = get_tree().reload_current_scene()


# determine if player in_range
func _on_AgroPher_body_entered(_body):
	in_agro_pher = true

func _on_AgroPher_body_exited(_body):
	in_agro_pher = false

func _on_AgroNoPher_body_entered(_body):
	in_agro_no_pher = true

func _on_AgroNoPher_body_exited(_body):
	in_agro_no_pher = false


func is_targetting() -> bool:
	return not player.is_queen and (in_agro_pher or (in_agro_no_pher and not player.has_pher))


func move_chaotically() -> void:
	var dir = linear_velocity.normalized().rotated(rand_range(-PI-THETA, -PI+THETA))
	linear_velocity = dir * (speed / 2.0)


func die():
	if is_alive:
		is_alive = false
		$AudioStreamPlayer2D.stop()
		$Particles2D.emitting = false
		$Sprite.playing = false
		$Sprite.modulate *= Color(0.6, 0.6, 0.6)
		$Stinger.queue_free()
