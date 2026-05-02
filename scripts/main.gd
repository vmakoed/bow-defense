extends Node2D


signal game_lost
signal game_won


const SCORE_PER_ENEMY = 100


var enemies_count: int
var enemy_hurt_particles_scene: Resource
var enemy_died_particles_scene: Resource
var score: int: set = _set_score
var total_waves: int


@onready var bow: Bow = %Bow
@onready var camera: Camera2D = %Camera2D
@onready var value_display: Node2D = %ValueDisplay
@onready var player: Player = %Player
@onready var spawner: Node = %ContinuousSpawner
@onready var stats_display: Control = %StatsDisplay


func _ready() -> void:
	score = 0
	enemy_hurt_particles_scene = preload("res://scenes/enemy_hurt_particles.tscn")
	enemy_died_particles_scene = preload("res://scenes/enemy_died_particles.tscn")
	# if not spawner.all_waves_spawned(): _spawn_next_wave()


func _set_score(new_value: int) -> void:
	if score == new_value: return
	score = new_value
	stats_display.update_score(score)


func _spawn_next_wave() -> void:
	pass
	# enemies_count = spawner.spawn_next_wave()
	# wave_label.text = "{current}/{total}".format({
	# 	"current": spawner.current_wave + 1, 
	# 	"total": spawner.total_waves()
	# })


func _emit_enemy_hit_particles(instance_position: Vector2, direction: Vector2, color: Color) -> void:
	var particles := enemy_hurt_particles_scene.instantiate() as CPUParticles2D
	particles.direction = direction
	_emit_particles(particles, instance_position, color)


func _emit_enemy_died_particles(instance_position: Vector2, color: Color) -> void:
	var particles := enemy_died_particles_scene.instantiate() as CPUParticles2D
	_emit_particles(particles, instance_position, color)


func _emit_particles(particles: CPUParticles2D, instance_position: Vector2, color: Color) -> void:
	particles.modulate = color
	particles.one_shot = true
	particles.emitting = true
	add_child(particles)
	particles.global_position = instance_position


func _on_player_tree_exited() -> void:
	bow.queue_free()


func _on_spawner_enemy_spawned(enemy: Enemy) -> void:
	enemy.damaged.connect(value_display.show_value_label)
	enemy.died.connect(_on_enemy_died)


func _on_enemy_died(enemy_position: Vector2, enemy_stats: EnemyStats) -> void:
	_emit_enemy_died_particles(enemy_position, enemy_stats.color)
	enemies_count -= 1
	score += SCORE_PER_ENEMY
	if enemies_count == 0: _on_wave_finished()


func _on_tower_destroyed() -> void:
	game_lost.emit()


func _on_wave_finished() -> void:
	pass
	# if spawner.all_waves_spawned():
	# 	game_won.emit()
	# else:
	# 	call_deferred("_spawn_next_wave")


func _on_virtual_joystick_plus_analogic_changed(
	value: Vector2, 
	distance: float, 
	_angle: float, 
	_angle_clockwise: float, 
	_angle_not_clockwise: float
) -> void:
	if distance == 0:return
	bow.aim(value * Vector2(-1, -1), distance)


func _on_virtual_joystick_plus_released() -> void:
	bow.release()


func _on_virtual_joystick_plus_pressed() -> void:
	bow.pull()


func _on_tower_damaged() -> void:
	camera.shake()	


func _on_bow_arrow_damaged(arrow_position: Vector2, area: HurtboxComponent, arrow_velocity: Vector2) -> void:
	var arrow_target = area.get_parent()
	if not (arrow_target is Enemy): return
	if not arrow_target.is_alive(): return
	
	_emit_enemy_hit_particles(
		arrow_position,
		arrow_velocity.normalized() * -1,
		arrow_target.enemy_stats.color
	)		


func _on_player_healed(amount: float, position_value: Vector2) -> void:
	value_display.show_value_label(amount, position_value, "+")
