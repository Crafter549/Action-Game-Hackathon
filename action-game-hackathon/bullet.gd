extends RigidBody2D

func _physics_process(delta):
	if (position - get_parent().get_child(1).position).length() > 3000:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if linear_velocity.length() < 500:
		queue_free()

func _on_inital_timer_timeout() -> void:
	set_collision_layer_value(3,true)
	set_collision_layer_value(4,true)
