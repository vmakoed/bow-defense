extends Node
class_name Spawner


signal enemy_spawned(enemy: Enemy)


@export var attack_target: Node2D
@export var enemy_scene: Resource
@export var enemy_stats: EnemyStats


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
