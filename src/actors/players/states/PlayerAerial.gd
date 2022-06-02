extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	
	# Get input direction
	player.direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	if player.direction > 0:
		player.sprite.flip_h = true
		player.is_facing_right = true
	elif player.direction < 0:
		player.sprite.flip_h = false
		player.is_facing_right = false
	
	# Calculate velocity
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		player.velocity.x = lerp(player.velocity.x, player.direction * player.max_speed, player.acceleration)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction)
	
	# Apply gravity
	if player.jump_buffer_timer.is_stopped():
		player.velocity.y += player.gravity * delta
	
	if Input.is_action_just_pressed("jump"):
		
		# Coyote jump
		if not player.coyote_timer.is_stopped():
			player.velocity.y = -player.jump_force
			player.coyote_timer.stop()
			player.jump_buffer_timer.stop()
		
		# Double Jump
		elif player.coyote_timer.is_stopped() and player.can_double_jump:
			player.velocity.y = -player.jump_force
			player.can_double_jump = false
	
	# Jump cancel
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.25
	
	# Apply movement
	player.velocity.y = player.move_and_slide(player.velocity, player.FLOOR_UP).y
	
	# State transition
	if player.is_on_floor():
		if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
			state_machine.transition_to("Walk")
		else:
			state_machine.transition_to("Idle")
	else:
		if Input.is_action_just_pressed("dash") and player.can_dash:
			state_machine.transition_to("Dash")

func enter(msg := {}) -> void:
	print("Aerial")
	
	player.animation_player.play("aerial")
	
	match msg.keys():
		["jump"]:
			player.velocity.y = -player.jump_force
		["floor_drop"]:
			player.coyote_timer.start()
			player.jump_buffer_timer.start()

func exit() -> void:
	pass
