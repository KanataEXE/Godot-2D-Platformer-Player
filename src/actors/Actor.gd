class_name Actor
extends KinematicBody2D

const FLOOR_UP := Vector2.UP

export var max_speed: float
export var jump_force: float
export var gravity: float

var velocity: Vector2

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func apply_movement() -> void:
	velocity.y = move_and_slide(velocity, FLOOR_UP).y

func die() -> void:
	pass
