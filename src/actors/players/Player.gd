class_name Player
extends Actor

signal died

onready var sprite := $Sprite
onready var animation_player := $AnimationPlayer
onready var dash_timer := $Timers/DashTimer
onready var coyote_timer := $Timers/CoyoteTimer
onready var jump_buffer_timer := $Timers/JumpBufferTimer
onready var coyote_wall_timer := $Timers/CoyoteWallTimer
onready var right_wall_raycast1 := $WallRayCasts/RightWallRayCast1
onready var right_wall_raycast2 := $WallRayCasts/RightWallRayCast2
onready var left_wall_raycast1 := $WallRayCasts/LeftWallRayCast1
onready var left_wall_raycast2 := $WallRayCasts/LeftWallRayCast2
onready var state_machine := $StateMachine

export var acceleration: float
export var ground_friction: float
export var air_friction: float
export var dash_speed: float
export var wall_gravity: float

var direction: float
var is_facing_right := true
var can_double_jump := true
var is_dashing := false
var can_dash := true

func check_right_wall() -> bool:
	return right_wall_raycast1.is_colliding() or right_wall_raycast2.is_colliding()

func check_left_wall() -> bool:
	return left_wall_raycast1.is_colliding() or left_wall_raycast2.is_colliding()

func die() -> void:
	state_machine.transition_to("Death")
