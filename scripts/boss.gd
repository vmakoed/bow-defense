extends Area2D


signal enemy_spawning(spawn_position: Vector2)


@onready var spawn_markers = %ProjectileSpawnMarkers


func _spawn_enemies() -> void:
	for marker: Marker2D in spawn_markers.get_children():
		enemy_spawning.emit(marker.global_position)


func _on_projectile_spawn_timer_timeout() -> void:
	_spawn_enemies()


func _on_first_attack_timer_timeout() -> void:
	_spawn_enemies()
	%ProjectileSpawnTimer.start()
