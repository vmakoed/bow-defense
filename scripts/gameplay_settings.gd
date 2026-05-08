extends PanelContainer


@onready var next_upgrade_goal_spin: SpinBox = %NextUpgradeGoalSpin
@onready var spawn_timeout_spin: SpinBox = %SpawnTimeoutSpin


func _ready() -> void:
	spawn_timeout_spin.step = GameConfig.SPAWN_RATE_PRECISION
	_on_next_upgrade_goal_changed_from_outside(GameConfig.next_upgrade_goal)
	_on_spawn_timeout_changed_from_outside(GameConfig.spawn_rate)
	GameConfig.next_upgrade_goal_changed.connect(_on_next_upgrade_goal_changed_from_outside)
	GameConfig.spawn_rate_changed.connect(_on_spawn_timeout_changed_from_outside)


func _on_spawn_timeout_changed_from_outside(value: float) -> void:
	spawn_timeout_spin.set_value_no_signal(value)


func _on_spawn_timeout_spin_value_changed(value: float) -> void:
	GameConfig.set_spawn_rate(value)


func _on_next_upgrade_goal_changed_from_outside(value: int) -> void:
	next_upgrade_goal_spin.set_value_no_signal(value)


func _on_next_upgrade_goal_spin_value_changed(value: int) -> void:
	GameConfig.set_next_upgrade_goal(value)
