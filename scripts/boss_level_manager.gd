extends Node


signal enemy_requested(spawn_position: Vector2)
signal particles_requested(particles: CPUParticles2D, instance_position: Vector2, color: Color)


enum BossPosition { LEFT, RIGHT }


var current_boss_position := BossPosition.RIGHT
var enemy_spawning_particles_scene := preload("res://scenes/enemy_spawn_particles.tscn")


@export var player: Node


@onready var boss_position_markers: Dictionary[BossPosition, Marker2D] = {
	BossPosition.LEFT: %LeftBossMarker,
	BossPosition.RIGHT: %RightBossMarker
}


func _ready() -> void:
	%Boss.global_position = boss_position_markers[current_boss_position].global_position


func _on_boss_damaged(_damage: Damage) -> void:
	if current_boss_position == BossPosition.RIGHT:
		current_boss_position = BossPosition.LEFT
	else:
		current_boss_position = BossPosition.RIGHT

	%Boss.global_position = boss_position_markers[current_boss_position].global_position


func _on_boss_enemy_spawning(spawn_position: Vector2) -> void:
	var enemy_position = player.global_position + Vector2(300.0, 0).rotated(randf() * 2 * PI)
	var particles := enemy_spawning_particles_scene.instantiate() as CPUParticles2D
	particles_requested.emit(particles, spawn_position, Color.WHITE)
	var tween = create_tween()
	tween.tween_property(
		particles, 
		"global_position", 
		enemy_position,
		0.8
	).from_current()
	tween.tween_callback(func(): enemy_requested.emit(enemy_position))
	
