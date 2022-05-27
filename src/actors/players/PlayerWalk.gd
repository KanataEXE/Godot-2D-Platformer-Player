extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	
	# Get input direction
	player.direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	if player.direction > 0:
		player.sprite.flip_h = true
		player.is_facing_right = true
	elif player.direction < 0:
		player.sprite.flip_h = false
		player.is_facing_right = false
	
	# Calculate velocity
	player.velocity.x = lerp(player.velocity.x, player.direction * player.max_speed, player.acceleration)
	
	# Apply movement
	player.velocity.y = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN * 9, player.FLOOR_UP).y
	
	# State transition
	if is_equal_approx(player.direction, 0):
		state_machine.transition_to("Idle")

func enter(_msg := {}) -> void:
	print("Walk")
	player.animation_player.play("walking")

func exit() -> void:
	pass
