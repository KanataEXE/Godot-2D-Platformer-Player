extends PlayerState

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	
	# Check floor
	if not player.is_on_floor():
		state_machine.transition_to("Aerial", {floor_drop = true})
	
	# Calculate velocity
	player.velocity.x = lerp(player.velocity.x, 0, player.ground_friction)
	
	# Apply movement
	player.velocity.y = player.move_and_slide_with_snap(player.velocity, Vector2.DOWN * 9, player.FLOOR_UP).y
	
	# State transition
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		state_machine.transition_to("Walk")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Aerial", {jump = true})
	elif Input.is_action_just_pressed("dash") and player.can_dash:
		state_machine.transition_to("Dash")

func enter(_msg := {}) -> void:
	print("Idle")
	player.can_double_jump = true
	player.can_dash = true
	player.animation_player.play("idle")

func exit() -> void:
	pass
