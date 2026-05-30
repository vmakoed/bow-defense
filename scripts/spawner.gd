extends Node
class_name Spawner


signal enemy_spawned(enemy: Enemy)


@export var attack_target: Node2D
@export var enemy_scene: Resource
@export var default_enemy_stats: EnemyStats
@export var spawn_radius: float


func start() -> void:
	pass


func get_random_spawn_position() -> Vector2:
		return attack_target.global_position + Vector2(spawn_radius, 0).rotated(randf() * 2 * PI)


func spawn_enemy(spawn_position: Vector2, enemy_stats := default_enemy_stats) -> Variant:
	match enemy_stats.spawn_strategy:
		_: return spawn_base_enemy(spawn_position, enemy_stats)


func spawn_base_enemy(spawn_position: Vector2, enemy_stats := default_enemy_stats) -> Enemy:
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
	return enemy
