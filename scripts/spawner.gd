extends Node
class_name Spawner


signal enemy_spawned


enum RelativePosition { 
	TOP_LEFT, CENTER_LEFT, BOTTOM_LEFT, 
	TOP_RIGHT, CENTER_RIGHT, BOTTOM_RIGHT
}


const WAVE_CONFIGURATIONS: Array[Array] = [
	[
		RelativePosition.CENTER_LEFT, RelativePosition.CENTER_RIGHT
	],
	[
		RelativePosition.TOP_LEFT, RelativePosition.BOTTOM_LEFT, 
		RelativePosition.TOP_RIGHT, RelativePosition.BOTTOM_RIGHT
	],
	[
		RelativePosition.TOP_LEFT, RelativePosition.CENTER_LEFT, RelativePosition.BOTTOM_LEFT, 
		RelativePosition.TOP_RIGHT, RelativePosition.CENTER_RIGHT, RelativePosition.BOTTOM_RIGHT
	],
]


var current_wave := -1
var current_enemy_count: int
var enemy_scene: Resource 


@onready var top_left_spawn_marker: Marker2D = %TopLeftSpawnMarker
@onready var center_left_spawn_marker: Marker2D = %CenterLeftSpawnMarker
@onready var bottom_left_spawn_marker: Marker2D = %BottomLeftSpawnMarker
@onready var top_right_spawn_marker: Marker2D = %TopRightSpawnMarker
@onready var center_right_spawn_marker: Marker2D = %CenterRightSpawnMarker
@onready var bottom_right_spawn_marker: Marker2D = %BottomRightSpawnMarker
@onready var spawn_markers: Dictionary[RelativePosition, Marker2D] = {
	RelativePosition.TOP_LEFT: top_left_spawn_marker,
	RelativePosition.CENTER_LEFT: center_left_spawn_marker, 
	RelativePosition.BOTTOM_LEFT: bottom_left_spawn_marker,
	RelativePosition.TOP_RIGHT: top_right_spawn_marker,
	RelativePosition.CENTER_RIGHT: center_right_spawn_marker,
	RelativePosition.BOTTOM_RIGHT: bottom_right_spawn_marker
}

@onready var top_left_home_marker: Marker2D = %TopLeftHomeMarker
@onready var center_left_home_marker: Marker2D = %CenterLeftHomeMarker
@onready var bottom_left_home_marker: Marker2D = %BottomLeftHomeMarker
@onready var top_right_home_marker: Marker2D = %TopRightHomeMarker
@onready var center_right_home_marker: Marker2D = %CenterRightHomeMarker
@onready var bottom_right_home_marker: Marker2D = %BottomRightHomeMarker
@onready var home_markers: Dictionary[RelativePosition, Marker2D] = {\
	RelativePosition.TOP_LEFT: top_left_home_marker, 
	RelativePosition.CENTER_LEFT: center_left_home_marker, 
	RelativePosition.BOTTOM_LEFT: bottom_left_home_marker,
	RelativePosition.TOP_RIGHT: top_right_home_marker,
	RelativePosition.CENTER_RIGHT: center_right_home_marker,
	RelativePosition.BOTTOM_RIGHT: bottom_right_home_marker
}

func _ready() -> void:
	enemy_scene = preload("res://scenes/enemy.tscn")
	

func spawn_next_wave() -> int:
	current_wave += 1

	var wave_configuration := WAVE_CONFIGURATIONS[current_wave]
	
	for enemy_spawn_position: RelativePosition in wave_configuration:
		var enemy = enemy_scene.instantiate() as Enemy
		enemy.initial_state = Enemy.State.FLYING_IN
		enemy.global_position = spawn_markers[enemy_spawn_position].global_position
		enemy.home_position = home_markers[enemy_spawn_position].global_position
		add_child(enemy)
		enemy_spawned.emit(enemy)

	return wave_configuration.size()


func all_waves_spawned() -> bool:
	return current_wave == WAVE_CONFIGURATIONS.size() - 1
