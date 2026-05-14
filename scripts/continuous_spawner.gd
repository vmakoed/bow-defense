extends Node


signal enemy_spawned(enemy: Enemy)


@export var attack_target: Node2D
@export var enemy_scene: Resource
@export var enemy_stats: EnemyStats
@export var spawn_radius: float
@export var spawn_timeout: float: set = set_spawn_timeout


@onready var endless_spawn_timer: Timer = %EndlessSpawnTimer


func _ready() -> void:
	set_spawn_timeout(GameConfig.spawn_rate)
	# GameConfig.spawn_rate_changed.connect(set_spawn_timeout)


func get_time_left() -> float:
	return endless_spawn_timer.time_left


func set_spawn_timeout(value: float) -> void:
	spawn_timeout = value
	endless_spawn_timer.wait_time = spawn_timeout
	endless_spawn_timer.start()


func spawn_enemy(spawn_position: Vector2) -> void:
	var enemy = enemy_scene.instantiate() as Enemy
	enemy.enemy_stats = enemy_stats
	enemy.initial_state = Enemy.State.ATTACKING
	enemy.global_position = spawn_position
	enemy.home_position = spawn_position
	enemy.attack_target_position = attack_target.global_position
	enemy.modulate = Color(1.0, 1.0, 1.0, 0.0)
	add_child(enemy)
	enemy_spawned.emit(enemy)
	var tween = create_tween()
	tween.tween_property(enemy, "modulate", Color.WHITE, 0.2).from_current()


func _on_endless_spawn_timer_timeout() -> void:
	pass
	# spawn_enemy(
	# 	attack_target.global_position + Vector2(spawn_radius, 0).rotated(randf() * 2 * PI)
	# )
