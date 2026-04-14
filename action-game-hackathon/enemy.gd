extends CharacterBody2D

@export var bullet_scene: PackedScene

func _physics_process(delta):
	$RayCast2D.target_position = get_parent().get_child(1).position - position

func _on_shoot_timer_timeout():
	if $RayCast2D.get_collider() == get_parent().get_child(1):
		var bullet = bullet_scene.instantiate()
		
		bullet.position = position
		bullet.linear_velocity = (get_parent().get_child(1).position - bullet.position + Vector2(0, -100)).normalized() * 1000
		bullet.linear_velocity = bullet.linear_velocity.rotated(randf_range(-PI/4, PI/4))
		
		bullet.rotation = bullet.linear_velocity.angle()
		
		get_parent().add_child(bullet)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	queue_free()
