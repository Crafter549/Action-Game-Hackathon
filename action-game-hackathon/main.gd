extends Node

@export var bullet_scene: PackedScene

func physics_process(delta):
	if Input.is_action_just_pressed("mouse_click"):
		var bullet = bullet_scene.instantiate()
