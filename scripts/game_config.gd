extends Node


signal next_upgrade_goal_changed(new_value: int)
signal spawn_rate_changed(new_value: float)


@export var spawn_rate := 2.0: set = set_spawn_rate
@export var next_upgrade_goal := 100: set = set_next_upgrade_goal


func set_next_upgrade_goal(value: int) -> void:
    if value == next_upgrade_goal: return
    next_upgrade_goal = value
    next_upgrade_goal_changed.emit(next_upgrade_goal)


func set_spawn_rate(value: float) -> void:
    if value == spawn_rate: return
    spawn_rate = value
    spawn_rate_changed.emit(spawn_rate)

