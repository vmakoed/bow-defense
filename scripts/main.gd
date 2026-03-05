extends Node2D


const LEFT_BOW_POSITION = 520.0
const RIGHT_BOW_POSITION = 632.0


@export var arrow_speed_baseline := 1200.0
@export var arrow_gravity_modifier := 800
@export var power_baseline := 600.0


var aiming: bool = false
var enemies_count: int


@onready var player: CharacterBody2D = %Player	
@onready var tower: StaticBody2D = %Tower
@onready var bow: Bow = %Bow
@onready var aim_indicator: Line2D = %AimIndicator
@onready var enemies: Node2D = %Enemies
@onready var spawner: Spawner = %Spawner


func _ready() -> void:
	_spawn_next_wave()


func _input(event: InputEvent) -> void:
	if !is_instance_valid(player):
		aim_indicator.clear_points()
		return
			
	if event is InputEventMouseButton: _perform_bow_action(event)
	if event is InputEventMouseMotion and aiming: 
		_refresh_aim_indicator(event) 
		bow.refresh_trajectory(event.position)


func _perform_bow_action(event: InputEventMouseButton) -> void:
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		aiming = true
		bow.pull(event.position)
	elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
		aiming = false
		aim_indicator.clear_points()
		bow.release()


func _refresh_aim_indicator(event: InputEventMouseMotion) -> void:
	aim_indicator.clear_points()
	aim_indicator.add_point(bow.pull_position)
	aim_indicator.add_point(event.position)
	

func _spawn_next_wave() -> void:
	enemies_count = spawner.spawn_next_wave()


func _on_bow_facing_changed(facing: Bow.Facing) -> void:
	if facing == Bow.Facing.LEFT:
		bow.position.x = LEFT_BOW_POSITION
	else:
		bow.position.x = RIGHT_BOW_POSITION


func _on_player_tree_exited() -> void:
	bow.queue_free()


func _on_spawner_enemy_spawned(enemy: Enemy) -> void:
	enemy.attack_target_position = Vector2(tower.global_position.x, enemy.global_position.y)
	enemy.died.connect(_on_enemy_died)


func _on_enemy_died() -> void:
	enemies_count -= 1
	if enemies_count != 0: return

	if spawner.all_waves_spawned():
		print("you win")
	else:
		_spawn_next_wave()
