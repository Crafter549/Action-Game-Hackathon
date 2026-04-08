extends CharacterBody2D
@export var bullet_scene:PackedScene

func _on_shoot_timer_timeout() -> void:
	var bullet =bullet_scene.instantiate()
	bullet.position=position
	bullet.linear_velocity.x=-1000
	
	
	
