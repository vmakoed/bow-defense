extends PanelContainer


func _ready() -> void:
	%SpawnTimeoutSpin.value = GameConfig.spawn_rate
	%NextUpgradeGoalSpin.value = GameConfig.next_upgrade_goal


func _on_spawn_timeout_spin_value_changed(value: float) -> void:
	GameConfig.set_spawn_rate(value)


func _on_next_upgrade_goal_spin_value_changed(value: int) -> void:
	GameConfig.set_next_upgrade_goal(value)
