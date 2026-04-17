extends Node

@export var bullet_scene: PackedScene

var gameActive = true

func _physics_process(delta):
	if gameActive:
		if Input.is_action_just_pressed("mouse_click"):
			var bullet = bullet_scene.instantiate()
			
			bullet.position = $Player.position
			bullet.linear_velocity = (get_viewport().get_mouse_position() - Vector2(960, 540) + $Camera.position - bullet.position + Vector2(0, -100)).normalized() * 1000
			bullet.linear_velocity = bullet.linear_velocity.rotated(randf_range(-PI/32, PI/32))
			
			bullet.rotation = (bullet.linear_velocity - $Player.velocity).angle()
			
			add_child(bullet)
		
		if $UI/HitOverlay.self_modulate.a > 0.02:
			$UI/HitOverlay.self_modulate.a -= 0.02
		else:
			$UI/HitOverlay.self_modulate.a = 0
	
	$Camera.position += ($Player.position + 0.3 * $Player.velocity + 0.4 * (get_viewport().get_mouse_position() - Vector2(960, 540)) - $Camera.position) * 0.03
	$UI.position = $Camera.position - Vector2(960, 540)
	
	if $UI/GameOverLabel.self_modulate.a < 0.98:
		$UI/GameOverLabel.self_modulate.a += 0.02
	else:
		$UI/GameOverLabel.self_modulate.a = 1
	
	if $UI/RespawnButton.self_modulate.a < 0.98:
		$UI/RespawnButton.self_modulate.a += 0.02
	else:
		$UI/RespawnButton.self_modulate.a = 1

func _on_player_player_hit():
	$UI/HitOverlay.self_modulate.a = 0.72
	$UI/HealthLabel.text = "Health: " + str($Player.health)

func _on_player_player_die():
	$UI/HitOverlay.self_modulate.a = 0.72
	$UI/HealthLabel.text = "Health: 0"
	
	$RespawnTimer1.start();
	
	gameActive = false

func _on_respawn_timer_1_timeout():
	$UI/GameOverLabel.show();
	$UI/GameOverLabel.self_modulate.a = 0;
	
	$RespawnTimer2.start();

func _on_respawn_timer_2_timeout():
	$UI/RespawnButton.show();
	$UI/RespawnButton.self_modulate.a = 0;

func _on_respawn_button_button_down():
	get_tree().reload_current_scene();
