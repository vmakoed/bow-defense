class_name ContinuousSpawner
extends Spawner


var enemies_wave: Array[EnemyStats]
var spawn_allowed := true: set = set_spawn_allowed
var spawn_timeout: float: set = set_spawn_timeout


@onready var endless_spawn_timer: Timer = %EndlessSpawnTimer


func _ready() -> void:
	set_spawn_timeout(GameConfig.spawn_rate)
	GameConfig.spawn_rate_changed.connect(set_spawn_timeout)


func any_enemies_left() -> bool:
	return enemies_wave.size() > 0


func set_spawn_allowed(value: bool) -> void:
	if value == spawn_allowed: return
	spawn_allowed = value
	if spawn_allowed:
		endless_spawn_timer.start()
	else:
		endless_spawn_timer.stop()


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
	var enemy_stats = enemies_wave.pop_back()
	if enemy_stats == null: return
	if not spawn_allowed: return

	spawn_enemy(get_random_spawn_position(), enemy_stats)
	endless_spawn_timer.start()
	
