extends Node
class_name Spawner


signal enemy_spawned


@onready var timer: Timer = %Timer


var current_wave: int
var current_enemy_count: int
var enemy_scene: Resource 
var enemy_waves: Array[EnemyWave]
var spawn_queue: EnemyWave

var bulky_square: EnemyStats
var speedy_square: EnemyStats
var standard_square: EnemyStats


@onready var top_left_spawn_marker: Marker2D = %TopLeftSpawnMarker
@onready var center_left_spawn_marker: Marker2D = %CenterLeftSpawnMarker
@onready var bottom_left_spawn_marker: Marker2D = %BottomLeftSpawnMarker
@onready var top_right_spawn_marker: Marker2D = %TopRightSpawnMarker
@onready var center_right_spawn_marker: Marker2D = %CenterRightSpawnMarker
@onready var bottom_right_spawn_marker: Marker2D = %BottomRightSpawnMarker
@onready var spawn_markers: Dictionary[Types.RelativePosition, Marker2D] = {
	Types.RelativePosition.TOP_LEFT: top_left_spawn_marker,
	Types.RelativePosition.CENTER_LEFT: center_left_spawn_marker, 
	Types.RelativePosition.BOTTOM_LEFT: bottom_left_spawn_marker,
	Types.RelativePosition.TOP_RIGHT: top_right_spawn_marker,
	Types.RelativePosition.CENTER_RIGHT: center_right_spawn_marker,
	Types.RelativePosition.BOTTOM_RIGHT: bottom_right_spawn_marker
}

@onready var top_left_home_marker: Marker2D = %TopLeftHomeMarker
@onready var center_left_home_marker: Marker2D = %CenterLeftHomeMarker
@onready var bottom_left_home_marker: Marker2D = %BottomLeftHomeMarker
@onready var top_right_home_marker: Marker2D = %TopRightHomeMarker
@onready var center_right_home_marker: Marker2D = %CenterRightHomeMarker
@onready var bottom_right_home_marker: Marker2D = %BottomRightHomeMarker
@onready var home_markers: Dictionary[Types.RelativePosition, Marker2D] = {\
	Types.RelativePosition.TOP_LEFT: top_left_home_marker, 
	Types.RelativePosition.CENTER_LEFT: center_left_home_marker, 
	Types.RelativePosition.BOTTOM_LEFT: bottom_left_home_marker,
	Types.RelativePosition.TOP_RIGHT: top_right_home_marker,
	Types.RelativePosition.CENTER_RIGHT: center_right_home_marker,
	Types.RelativePosition.BOTTOM_RIGHT: bottom_right_home_marker
}


func _ready() -> void:
	enemy_scene = preload("res://scenes/enemy.tscn")
	bulky_square = preload("res://resources/bulky_square.tres")
	speedy_square = preload("res://resources/speedy_square.tres")
	standard_square = preload("res://resources/standard_square.tres")
	current_wave = -1
	_create_enemy_waves()
	

func spawn_next_wave() -> int:
	current_wave += 1
	spawn_queue = enemy_waves[current_wave]
	timer.start()
	return spawn_queue.size()


func all_waves_spawned() -> bool:
	return current_wave == total_waves() - 1


func total_waves() -> int:
	return enemy_waves.size()


func _create_enemy_waves() -> void:
	# Wave 1
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.CENTER_RIGHT: standard_square,
			Types.RelativePosition.CENTER_LEFT: standard_square,
		})
	)
	# Wave 2
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.BOTTOM_RIGHT: standard_square,
			Types.RelativePosition.TOP_LEFT: standard_square,
		})
	)
	# Wave 3
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.TOP_RIGHT: standard_square,
			Types.RelativePosition.CENTER_LEFT: standard_square,
			Types.RelativePosition.BOTTOM_LEFT: standard_square,
			Types.RelativePosition.CENTER_RIGHT: standard_square,
		})
	)
	# Wave 4
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.CENTER_RIGHT: bulky_square,
			Types.RelativePosition.CENTER_LEFT: standard_square,
		})
	)
	# Wave 5
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.BOTTOM_RIGHT: bulky_square,
			Types.RelativePosition.CENTER_LEFT: bulky_square,
			Types.RelativePosition.TOP_LEFT: standard_square,
		})
	)
	# Wave 6
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.CENTER_RIGHT: standard_square,
			Types.RelativePosition.CENTER_LEFT: speedy_square,
		})
	)
	# Wave 7
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.TOP_RIGHT: speedy_square,
			Types.RelativePosition.BOTTOM_LEFT: standard_square,
			Types.RelativePosition.TOP_LEFT: speedy_square,
			Types.RelativePosition.BOTTOM_RIGHT: standard_square,
		})
	)
	# Wave 8
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.TOP_RIGHT: bulky_square,
			Types.RelativePosition.BOTTOM_LEFT: speedy_square,
			Types.RelativePosition.TOP_LEFT: bulky_square,
			Types.RelativePosition.BOTTOM_RIGHT: speedy_square,
		})
	)
	# Wave 9
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.TOP_RIGHT: bulky_square,
			Types.RelativePosition.BOTTOM_LEFT: bulky_square,
			Types.RelativePosition.TOP_LEFT: bulky_square,
			Types.RelativePosition.BOTTOM_RIGHT: bulky_square,
			Types.RelativePosition.CENTER_RIGHT: standard_square,
			Types.RelativePosition.CENTER_LEFT: standard_square,
		})
	)
	# Wave 10
	enemy_waves.push_back(
		_create_enemy_wave({
			Types.RelativePosition.TOP_RIGHT: speedy_square,
			Types.RelativePosition.BOTTOM_LEFT: speedy_square,
			Types.RelativePosition.TOP_LEFT: speedy_square,
			Types.RelativePosition.BOTTOM_RIGHT: speedy_square,
			Types.RelativePosition.CENTER_RIGHT: bulky_square,
			Types.RelativePosition.CENTER_LEFT: bulky_square,
		})
	)
	

func _create_enemy_wave(configuration: Dictionary[Types.RelativePosition, EnemyStats]) -> EnemyWave:
	var enemy_wave = EnemyWave.new()
	for spawn_position in configuration: enemy_wave.set_position(
		spawn_position,
		configuration[spawn_position]
	)
	return enemy_wave


func _spawn_enemy(wave_entry: EnemyWaveEntry) -> void:
	var enemy = wave_entry.enemy
	enemy.initial_state = Enemy.State.FLYING_IN
	enemy.global_position = spawn_markers[wave_entry.spawn_position].global_position
	enemy.home_position = home_markers[wave_entry.spawn_position].global_position
	add_child(enemy)
	enemy_spawned.emit(enemy)


func _on_timer_timeout() -> void:
	_spawn_enemy(spawn_queue.pop_back())
	if spawn_queue.is_empty(): return
	timer.start()
