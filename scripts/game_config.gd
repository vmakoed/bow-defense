extends Node


signal next_upgrade_goal_changed(new_value: int)
signal spawn_rate_changed(new_value: float)


const SPAWN_RATE_PRECISION = 0.1


@export var healing_amount = 0.5
@export var explosive_damage = 3.0
@export var max_player_health = 50.0
@export var next_upgrade_goal := 5: set = set_next_upgrade_goal
@export var score_per_enemy := 1
@export var spawn_rate_multiplier := 0.5
@export var spawn_rate := 4.0: set = set_spawn_rate
@export var upgrade_increase := 10
@export var upgrade_selection_limit := 3


func _ready() -> void:
	PlayerStats.upgrade_added.connect(_on_player_upgrade_added)


func reset() -> void:
	next_upgrade_goal = 5
	spawn_rate = 4.0

func set_next_upgrade_goal(value: int) -> void:
	if value == next_upgrade_goal: return
	next_upgrade_goal = value
	next_upgrade_goal_changed.emit(next_upgrade_goal)


func set_spawn_rate(value: float) -> void:
	if value == spawn_rate: return
	spawn_rate = value
	spawn_rate_changed.emit(spawn_rate)


func _on_player_upgrade_added(_upgrade: PlayerUpgrade) -> void:
	next_upgrade_goal += upgrade_increase
	spawn_rate = snappedf(spawn_rate * spawn_rate_multiplier, SPAWN_RATE_PRECISION)
