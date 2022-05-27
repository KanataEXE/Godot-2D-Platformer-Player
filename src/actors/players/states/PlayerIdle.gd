extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	
	# Calculate velocity
	player.velocity.x = lerp(player.velocity.x, 0, player.ground_friction)
	
	# Apply movement
	player.velocity.y = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN * 9, player.FLOOR_UP).y
	
	# State transition
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		state_machine.transition_to("Walk")

func enter(_msg := {}) -> void:
	print("Idle")
	player.animation_player.play("idle")

func exit() -> void:
	pass
