extends RigidBody2D



	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	if(linear_velocity.length()<700):
		queue_free()


func _on_inital_timer_timeout() -> void:
	set_collision_layer_value(3,true)
	set_collision_layer_value(4,true)
