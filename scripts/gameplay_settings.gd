extends PanelContainer
# TODO: implement a single source of truth for settings in autoload


signal spawn_timeout_changed(value: float)


func _on_spawn_timeout_spin_value_changed(value: float) -> void:
	spawn_timeout_changed.emit(value)
