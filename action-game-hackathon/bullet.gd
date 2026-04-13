extends RigidBody2D


	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	print("test")
	if(linear_velocity.length()<700):
		queue_free()
