extends Node

@export var bullet_scene: PackedScene

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		var bullet = bullet_scene.instantiate()
		
		bullet.position = $Player.position
		bullet.linear_velocity = (get_viewport().get_mouse_position() - Vector2(960, 540) + $Camera.position - bullet.position + Vector2(0, -100)).normalized() * 1000
		
		bullet.rotation = (bullet.linear_velocity - $Player.velocity).angle()
		
		add_child(bullet)
	
	$Camera.position += ($Player.position + 0.3 * $Player.velocity + 0.4 * (get_viewport().get_mouse_position() - Vector2(960, 540)) - $Camera.position) * 0.03
	$UI.position = $Camera.position - Vector2(960, 540)
	
	$UI/HitOverlay.self_modulate.a -= 0.02

func _on_player_player_hit():
	$UI/HitOverlay.self_modulate.a = 0.72
	$UI/HealthLabel.text = "Health: " + str($Player.health)

func _on_player_player_die():
	$UI/HealthLabel.text = "Health: 0"
