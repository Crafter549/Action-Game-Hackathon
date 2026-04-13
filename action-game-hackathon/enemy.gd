extends CharacterBody2D

@export var bullet_scene:PackedScene

func _on_shoot_timer_timeout():
	var bullet = bullet_scene.instantiate()
	
	bullet.position = get_parent().get_child(2).position
	bullet.linear_velocity = (get_parent().get_child(1).position-bullet.position).normalized()*1000
	bullet.linear_velocity = bullet.linear_velocity.rotated(randf_range(-PI/4,PI/4))
	
	bullet.rotation = bullet.linear_velocity.angle()
	
	get_parent().add_child(bullet)
	
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("dead")
	queue_free()
