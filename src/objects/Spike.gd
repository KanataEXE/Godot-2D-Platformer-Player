extends Area2D

func _on_body_entered(body: Node) -> void:
	if body is Player:
		if body.has_method("die"):
			body.die()
