extends Node
class_name Spawner


signal enemy_spawned(enemy: Enemy)


@export var attack_target: Node2D
@export var boss_scene := preload("res://scenes/boss.tscn")
@export var enemy_scene := preload("res://scenes/enemy.tscn")
@export var default_enemy_stats := preload("res://resources/enemy_stats/plain_square.tres")
@export var shielded_enemy_stats := preload("res://resources/enemy_stats/plain_shielded_square.tres")
@export var shielder_pair_scene := preload("res://scenes/shielder_pair.tscn")
@export var spawn_radius: float


func start() -> void:
	pass


func get_random_spawn_position() -> Vector2:
	return attack_target.global_position + Vector2(spawn_radius, 0).rotated(randf() * 2 * PI)


func spawn_enemy(spawn_position: Vector2, enemy_stats := default_enemy_stats) -> Variant:
	match enemy_stats.spawn_strategy:
		EnemyStats.SpawnStrategy.SHIELDER: return spawn_shielder_enemy(spawn_position, enemy_stats)
		EnemyStats.SpawnStrategy.BOSS: return spawn_boss_enemy(enemy_stats)
		_: return spawn_base_enemy(spawn_position, enemy_stats)


func spawn_base_enemy(spawn_position: Vector2, enemy_stats: EnemyStats) -> Enemy:
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


func spawn_shielder_enemy(spawn_positon: Vector2, enemy_stats: EnemyStats) -> Enemy:
	var shielder: Enemy = spawn_base_enemy(spawn_positon, enemy_stats)
	var enemy: Enemy = spawn_enemy(get_random_spawn_position(), shielded_enemy_stats)
	enemy.add_area_shield(shielder)
	var shielder_pair = shielder_pair_scene.instantiate() as ShielderPair
	shielder_pair.enemy = enemy
	shielder_pair.shielder = shielder
	add_child(shielder_pair)
	return shielder


func spawn_boss_enemy(enemy_stats: EnemyStats) -> Boss:
	# TODO: actually use EnemyStats for boss
	var boss: Boss = boss_scene.instantiate() as Boss
	boss.attack_target = attack_target	# change to position
	boss.enemy_stats = enemy_stats
	add_child(boss)
	enemy_spawned.emit(boss)
	return boss
