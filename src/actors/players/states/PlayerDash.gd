extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	
	player.velocity.y = player.move_and_slide(player.velocity, player.FLOOR_UP).y
	
	if player.dash_timer.is_stopped():
		if player.is_on_floor():
			if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
				state_machine.transition_to("Walk")
			else:
				state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Aerial")

func enter(_msg := {}) -> void:
	print("Dash")
	
	if Input.is_action_pressed("down") or Input.is_action_pressed("up"):
		player.velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		player.velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		player.velocity = player.velocity.normalized() * player.dash_speed
	else:
		player.velocity.x = player.dash_speed if player.is_facing_right else -player.dash_speed
		player.velocity.y = 0
	
	player.can_dash = false
	player.dash_timer.start()

func exit() -> void:
	pass
