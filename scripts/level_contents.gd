class_name LevelContents
extends Node2D


signal enemy_died(enemy: BaseEnemy)
signal enemy_spawned(enemy: BaseEnemy)
signal upgrade_reached
signal game_paused
signal level_lost
signal level_won


@export var enemy_died_audio_stream: AudioStream = preload("res://assets/audio/sndHit7trimmed.wav")
@export var explosion_packed: PackedScene = preload("res://scenes/explosion.tscn")
@export var enemies_wave: Array[EnemyStats]


var enemies_count: int
var enemy_hurt_particles_scene = preload("res://scenes/enemy_hurt_particles.tscn")
var enemy_died_particles_scene = preload("res://scenes/enemy_died_particles.tscn")
var score: int: set = _set_score


@onready var bow: Bow = %Bow
@onready var camera: Camera2D = %Camera2D
@onready var player: Player = %Player
@onready var spawner = %Spawner


func _ready() -> void:
	PlayerStats.clear_upgrades()
	GameConfig.reset()
	GameUIBridge.virtual_joystick_plus_analogic_changed.connect(_on_virtual_joystick_plus_analogic_changed)
	GameUIBridge.virtual_joystick_plus_pressed.connect(_on_virtual_joystick_plus_pressed)
	GameUIBridge.virtual_joystick_plus_released.connect(_on_virtual_joystick_plus_released)
	GameUIBridge.level_started.emit()
	score = 0
	spawner.enemies_wave = enemies_wave
	spawner.enemy_spawned.connect(_on_spawner_enemy_spawned)
	spawner.start()


func _set_score(new_value: int) -> void:
	if score == new_value: return
	score = new_value


func _create_explosion(explosion_position: Vector2, damage: float) -> void:
	var explosion = explosion_packed.instantiate()
	explosion.damage_amount = damage
	explosion.position = explosion_position
	add_child.call_deferred(explosion)


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


func _emit_enemy_died_particles(instance_position: Vector2, color = Color.WHITE) -> void:
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


func _on_spawner_enemy_spawned(enemy: BaseEnemy) -> void:
	enemy.damaged.connect(_on_enemy_damaged)
	enemy.died.connect(func(): _on_enemy_died(enemy))
	enemy.killed.connect(_on_enemy_killed)
	enemy_spawned.emit(enemy)


func _on_enemy_damaged(damage: Damage) -> void:
	GameUIBridge.value_display_requested.emit(damage.amount, damage.source_global_position)


func _on_enemy_died(enemy: BaseEnemy) -> void:
	enemy_died.emit(enemy)
	SfxSoundController.play_audio(enemy_died_audio_stream)
	_emit_enemy_died_particles(enemy.global_position, enemy.enemy_stats.color)
	enemy.queue_free()
	enemies_count -= 1
	if enemies_count == 0: _on_wave_finished()
	


func _on_enemy_killed() -> void:
	score += GameConfig.score_per_enemy
	# do not use score as a goal. instead check if spawner is empty and enemies group is empty on enemy killed
	if spawner.any_enemies_left(): return
	if get_tree().get_nodes_in_group("enemies").any(func(enemy): return enemy.is_alive()): return
	level_won.emit()
	# if score >= GameConfig.next_upgrade_goal: upgrade_reached.emit()


func _on_tower_destroyed() -> void:
	level_lost.emit()


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
	GameUIBridge.controls_label_hide_requested.emit()
	var arrow_target = area.get_parent()
	if not ((arrow_target is Enemy) or (arrow_target is Boss)): return
	if not arrow_target.is_alive(): return
	
	_emit_enemy_hit_particles(
		arrow_position,
		arrow_velocity.normalized() * -1,
		arrow_target.enemy_stats.color
	)


func _on_bow_arrow_exploded(arrow_position: Vector2, explosive_damage: float) -> void:
	_create_explosion(arrow_position, explosive_damage)


func _on_pause_button_pressed() -> void:
	game_paused.emit()


func _on_player_healed(amount: float, position_value: Vector2) -> void:
	GameUIBridge.signed_value_display_requested.emit(amount, position_value, "+")


func _on_player_destroyed() -> void:
	level_lost.emit()


func _on_level_won() -> void:
	level_won.emit()
