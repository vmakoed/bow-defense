class_name EnemyWave
extends RefCounted
## Represents a single wave's enemy configuration.
## Uses a Dictionary keyed by RelativePosition to enforce
## one enemy type per spawn position at authoring time.
## Consumed sequentially via pop_back().

var configuration: Dictionary[Types.RelativePosition, EnemyStats]


func set_position(spawn_position: Types.RelativePosition, enemy_stats: EnemyStats) -> void:
	configuration[spawn_position] = enemy_stats


func pop_back() -> EnemyWaveEntry:
	var spawn_position = configuration.keys().back()
	var enemy_stats = configuration[spawn_position]
	configuration.erase(spawn_position)
	return EnemyWaveEntryFactory.create(spawn_position, enemy_stats)


func size() -> int:
	return configuration.size()


func is_empty() -> bool:
	return configuration.is_empty()
