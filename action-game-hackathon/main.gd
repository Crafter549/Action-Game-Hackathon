extends Node

@export var bullet_scene: PackedScene

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		var bullet = bullet_scene.instantiate()
		
		bullet.position = $Player.position
		bullet.linear_velocity = (get_viewport().get_mouse_position() + $Camera.position - Vector2(960, 540) - bullet.position + Vector2(0, -100)).normalized() * 1000
		
		bullet.rotation = (bullet.linear_velocity - $Player.velocity).angle()
		
		add_child(bullet)
	
	$Camera.position += ($Player.position + 0.1 * $Player.velocity - $Camera.position) * 0.05
