extends Node2D


signal game_won
signal game_lost


const BOW_POSITIONS: Dictionary[Bow.Facing, float] = {
	Bow.Facing.LEFT: 520.0,
	Bow.Facing.RIGHT: 632.0
}


var enemies_count: int


@onready var tower: StaticBody2D = %Tower
@onready var bow: Bow = %Bow
@onready var spawner: Spawner = %Spawner
@onready var camera: Camera2D = %Camera2D


func _ready() -> void:
	if not spawner.all_waves_spawned(): _spawn_next_wave()
	

func _spawn_next_wave() -> void:
	enemies_count = spawner.spawn_next_wave()


func _on_bow_facing_changed(facing: Bow.Facing) -> void:
	bow.position.x = BOW_POSITIONS[facing]


func _on_player_tree_exited() -> void:
	bow.queue_free()


func _on_spawner_enemy_spawned(enemy: Enemy) -> void:
	enemy.attack_target_position = Vector2(tower.global_position.x, enemy.global_position.y)
	enemy.died.connect(_on_enemy_died)


func _on_enemy_died() -> void:
	enemies_count -= 1
	if enemies_count != 0: return
	if spawner.all_waves_spawned():
		game_won.emit()
	else:
		call_deferred("_spawn_next_wave")


func _on_tower_destroyed() -> void:
	game_lost.emit()


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
