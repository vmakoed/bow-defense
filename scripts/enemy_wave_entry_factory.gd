class_name EnemyWaveEntryFactory
extends RefCounted


const ENEMY_SCENE = preload("res://scenes/enemy.tscn")


static func create(spawn_position: Types.RelativePosition, enemy_stats: EnemyStats) -> EnemyWaveEntry:
	var enemy = ENEMY_SCENE.instantiate() as Enemy
	enemy.enemy_stats = enemy_stats

	var wave_entry = EnemyWaveEntry.new()
	wave_entry.spawn_position = spawn_position
	wave_entry.enemy = enemy
	return wave_entry
