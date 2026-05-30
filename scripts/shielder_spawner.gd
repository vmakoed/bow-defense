extends ContinuousSpawner


@export var shielder_pair_scene: PackedScene


func spawn_enemy(spawn_positon: Vector2, enemy_stats := default_enemy_stats) -> Enemy:
	var shielder: Enemy = super(spawn_positon)
	var enemy: Enemy = super(get_random_spawn_position())
	enemy.add_area_shield(shielder)
	var shielder_pair = shielder_pair_scene.instantiate() as ShielderPair
	shielder_pair.enemy = enemy
	shielder_pair.shielder = shielder
	add_child(shielder_pair)
	return enemy
