extends Node

@export var bullet_scene: PackedScene

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		print("benwquiy")
		
		var bullet = bullet_scene.instantiate()
		
		bullet.position = $Player.position
		bullet.linear_velocity = (get_viewport().get_mouse_position() - bullet.position).normalized() * 2000
		
		add_child(bullet)
