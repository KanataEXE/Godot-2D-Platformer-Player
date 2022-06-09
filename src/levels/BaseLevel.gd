extends Node2D

func level_reset() -> void:
	get_tree().reload_current_scene()
