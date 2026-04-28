extends Node


signal enemy_spawned


@export var attack_target: Node2D
@export var enemy_scene: Resource
@export var enemy_stats: EnemyStats
@export var spawn_radius: float


func _on_endless_spawn_timer_timeout() -> void:
	var rotation = randf() * 2 * PI
	var spawn_position = attack_target.global_position + Vector2(spawn_radius, 0).rotated(rotation)
	var enemy = enemy_scene.instantiate() as Enemy
	enemy.enemy_stats = enemy_stats
	enemy.initial_state = Enemy.State.ATTACKING
	enemy.global_position = spawn_position
	enemy.home_position = spawn_position
	enemy.attack_target_position = attack_target.global_position
	add_child(enemy)
	enemy_spawned.emit(enemy)
