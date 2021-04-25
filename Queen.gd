extends RigidBody2D


var is_alive = true
var speed := 160
var in_agro_pher := false
var in_agro_no_pher := false
var pher : int = 2

onready var player = get_tree().get_root().get_node("World/Player")
onready var world = get_tree().get_root().get_node("World")


func _ready():
	$AgroPher/CollisionShape2D.shape.radius = 100
	$Particles2D.scale.x = 2.0
	$Particles2D.scale.y = 2.0
	$Sprite.scale.x = 2.0
	$Sprite.scale.y = 2.0
	$Sprite.modulate = Color(1.5, 1.5, 1.5)
	linear_damp = 1
	linear_velocity = Vector2(speed, 0).rotated(rand_range(0, 2*PI))


func _process(_delta):
	if is_alive:
		if is_targetting():
			target()
		else:
			move_chaotically()


func target():
	angular_velocity = -10
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
	return in_agro_pher or (in_agro_no_pher and not player.has_pher)


func move_chaotically() -> void:
	var dir = linear_velocity.normalized().rotated(rand_range(-PI/3, PI/3))
	linear_velocity = dir * (speed / 4.0)


func die():
	if is_alive:
		is_alive = false
		$AudioStreamPlayer2D.stop()
		$Particles2D.emitting = false
		$Sprite.playing = false
		$Sprite.modulate *= Color(0.4, 0.4, 0.4)
		$Stinger.queue_free()
		
		player.is_queen = true
		player.get_node("PherTimer").paused = true
		player.get_node("ProgressBar").visible = false
		player.get_node("Sprite").modulate = Color(1.5, 1.5, 1.5)
		player.get_node("Particles2D").scale.x = 2.0
		player.get_node("Particles2D").scale.y = 2.0
		player.get_node("WinText").visible = true
		player.get_node("WinText/Label2").text = get_win_text()


func get_win_text() -> String:
	var string := "ruler of "
	var num_bees := str(get_num_bees())
	string += num_bees + " remaining bee"
	if num_bees != "1":
		string += "s"
	string += "."
	return string


func get_num_bees() -> int:
	var num = 0
	for enemy in world.get_node("Enemies").get_children():
		if enemy.is_alive:
			num += 1
	return num
