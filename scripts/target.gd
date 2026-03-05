extends Area2D


func _on_health_component_health_below_minimum() -> void:
	queue_free()
