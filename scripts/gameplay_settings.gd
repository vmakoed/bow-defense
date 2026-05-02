extends PanelContainer


@export var spawner: Node


func _on_spawn_timeout_spin_value_changed(value: float) -> void:
	spawner.spawn_timeout = value
