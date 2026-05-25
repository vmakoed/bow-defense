class_name ContinuousSpawner
extends Spawner


var spawn_timeout: float: set = set_spawn_timeout


@onready var endless_spawn_timer: Timer = %EndlessSpawnTimer


func _ready() -> void:
	set_spawn_timeout(GameConfig.spawn_rate)
	GameConfig.spawn_rate_changed.connect(set_spawn_timeout)


func start() -> void:
	endless_spawn_timer.timeout.emit()
	endless_spawn_timer.start()


func get_time_left() -> float:
	return endless_spawn_timer.time_left


func set_spawn_timeout(value: float) -> void:
	spawn_timeout = value
	endless_spawn_timer.wait_time = spawn_timeout
	endless_spawn_timer.start()


func _on_endless_spawn_timer_timeout() -> void:
	spawn_enemy(get_random_spawn_position())
