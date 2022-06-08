extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	
	# Apply gravity
	player.velocity.y += player.wall_gravity * delta
	
	# Apply movement
	player.velocity.y = player.move_and_slide(player.velocity, player.FLOOR_UP).y
	
	# State transition
	if player.is_on_floor():
		if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			state_machine.transition_to("Walk")
		else:
			state_machine.transition_to("Idle")
	else:
		if player.check_right_wall() or player.check_left_wall():
			if Input.is_action_just_pressed("jump"):
				state_machine.transition_to("Aerial", {wall_jump = true})
			elif Input.is_action_pressed("right") and player.check_left_wall():
				state_machine.transition_to("Aerial", {wall_drop = true})
			elif Input.is_action_pressed("left") and player.check_right_wall():
				state_machine.transition_to("Aerial", {wall_drop = true})
		else:
			state_machine.transition_to("Aerial")

func enter(_msg := {}) -> void:
	print("Wall")
	
	player.can_double_jump = true
	player.can_dash = true
	player.velocity.x = 0
	
	if player.check_left_wall():
		player.sprite.flip_h = true
		player.is_facing_right = true
	
	if player.check_right_wall():
		player.sprite.flip_h = false
		player.is_facing_right = false

func exit() -> void:
	pass
